# == Class: ovirt
#
# The ovirt::node class installs oVirt Node.
#
# === Authors
#
# Jason Cannon <jason@thisidig.com>
#
class ovirt::node inherits ovirt {

  if $ovirt::download_rpm {
    $require_package = Package[$ovirt::ovirt_release]
  }
  else {
    $require_package = undef
  }

  package { 'vdsm':
    ensure  => installed,
    require => $require_package,
  }

  service { 'vdsmd':
    ensure  => 'running',
    enable  => true,
    require => Package['vdsm'],
  }

}
