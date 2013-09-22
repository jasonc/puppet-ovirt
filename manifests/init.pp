# == Class: ovirt
#
# This class contains the common requirements of ovirt::engine and ovirt::node.
#
# === Authors
#
# Jason Cannon <jason@thisidig.com>
#
class ovirt {

  $ovirt_os = $operatingsystem ? {
    centos  => 'el6',
    redhat  => 'el6',
    fedora  => 'fedora',
    default => undef,
  }

  if $ovirt_os == undef {
    fail("The ${operatingsystem} operating system is not supported.")
  }

  $ovirt_release_version="8-1"
  $ovirt_release="ovirt-release-${ovirt_os}-${ovirt_release_version}"

  package { $ovirt_release:
    provider => 'rpm',
    ensure => installed,
    source => "http://ovirt.org/releases/$ovirt_release.noarch.rpm",
  }

}
