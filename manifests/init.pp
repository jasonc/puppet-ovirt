# == Class: ovirt
#
# This class contains the common requirements of ovirt::engine and ovirt::node.
#
# === Authors
#
# Jason Cannon <jason@thisidig.com>
#
class ovirt {

  $ovirt_os = $::operatingsystem ? {
    centos  => 'el6',
    redhat  => 'el6',
    fedora  => 'fedora',
    default => undef,
  }

  if $ovirt_os == undef {
    fail("The ${::operatingsystem} operating system is not supported.")
  }

  $ovirt_release="ovirt-release-${ovirt_os}"

  package { $ovirt_release:
    ensure   => installed,
    provider => 'rpm',
    source   => "http://ovirt.org/releases/${ovirt_release}.noarch.rpm",
  }

}
