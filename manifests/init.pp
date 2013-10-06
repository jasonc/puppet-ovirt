# == Class: ovirt
#
# This class contains the common requirements of ovirt::engine and ovirt::node.
#
# === Parameters
#
# [*ovirt_release_base_url*]
#   This setting can be used to override the default url of http://ovirt.org/releases.
#
# === Authors
#
# Jason Cannon <jason@thisidig.com>
#
class ovirt(
  $ovirt_release_base_url = 'http://ovirt.org/releases'
) {

  case $::operatingsystem {
    centos, redhat: {
      $ovirt_release     = 'ovirt-release-el6'
      $ovirt_release_url = "${ovirt_release_base_url}/ovirt-release-el.noarch.rpm"
    }
    fedora: {
      $ovirt_release     = 'ovirt-release-fedora'
      $ovirt_release_url = "${ovirt_release_base_url}/${ovirt_release}.noarch.rpm"
    }
    default: {
      fail("The ${::operatingsystem} operating system is not supported.")
    }
  }

  package { $ovirt_release:
    ensure   => installed,
    provider => 'rpm',
    source   => $ovirt_release_url,
  }

}
