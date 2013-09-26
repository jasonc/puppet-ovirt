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
    ensure  => installed,
    require => Package[$ovirt::ovirt_release],
  }

  service { 'vdsmd':
    ensure  => 'running',
    enable  => true,
    require => Package['vdsm'],
  }

}
