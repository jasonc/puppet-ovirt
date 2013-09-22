# == Class: ovirt
#
# The ovirt::node class installs oVirt Node.
#
# === Authors
#
# Jason Cannon <jason@thisidig.com>
#
class ovirt::node inherits ovirt {

  package { 'vdsm':
    ensure => installed,
    require => Package[$ovirt_release],
  }

  service { 'vdsmd':
    enable => true,
    ensure => 'running',
    require => Package['vdsm'],
  }

}
