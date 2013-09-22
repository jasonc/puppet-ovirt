# == Class: ovirt::engine
#
# The ovirt::engine class installs oVirt Engine.
#
# === Parameters
#
# [*applicationMode*]
#   This setting can be used to override the default ovirt application mode of both.  Valid options are both, virt, gluster.
#
# [*storageType*]
#   This setting can be used to override the default ovirt storage type of nfs.  Valid options are nfs, fc, iscsi, and posixfs.
#
# [*organization*]
#   This setting can be used to override the default ovirt PKI organization of localdomain.
#
# [*nfsConfigEnabled*]
#   This setting can be used to override the default ovirt nfs configuration of true.  Valid options are true and false.
#
# [*isoDomainName*]
#   This setting can be used to override the default ISO Domain Name of ISO_DOMAIN.
#
# [*isoDomainMountPoint*]
#   This setting can be used to override the default ISO Domain Mount Point of /var/lib/exports/iso.
#
# [*adminPassword*]
#   This setting can be used to override the default ovirt admin password of admin.
#
# [*dbPassword*]
#   This setting can be used to override the default database password of dbpassword.
#
# [*dbHost*]
#   This setting can be used to override the default database host of localhost.
#
# [*dbPort*]
#   This setting can be used to override the default database port of 5432.
#
# [*firewallManager*]
#   This setting can be used to override the default firewall manager.  The module uses iptables for RHEL and CentOS and firewalld for Fedora by default.  Valid options are iptables and firewalld.
#
# === Examples
#
#  class { ovirt::engine:
#    applicationMode => 'ovirt',
#    storageType     => 'fc',
#    organization    => 'example.com',
#  }
#
# === Authors
#
# Jason Cannon <jason@thisidig.com>
#
class ovirt::engine(
  $applicationMode = 'both', # both, virt, gluster
  $storageType = 'nfs', # nfs, fc, iscsi, posixfs
  $organization = 'localdomain',
  $nfsConfigEnabled = true, # true, false
  $isoDomainName = 'ISO_DOMAIN',
  $isoDomainMountPoint = '/var/lib/exports/iso',
  $adminPassword = 'admin',
  $dbPassword = 'dbpassword',
  $dbHost = 'localhost',
  $dbPort = '5432',
  $firewallManager = $operatingsystem ? {
    /(?i-mx:centos|redhat)/        => 'iptables',
    /(?i-mx:fedora)/ => 'firewalld',
  }
) inherits ovirt {

  package { 'ovirt-engine':
    ensure => installed,
    require => Package[$ovirt_release],
    notify => Exec[engine-setup],
  }

  $answers_file="/var/lib/ovirt-engine/setup/answers/answers-from-puppet"

  file { $answers_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[ovirt-engine],
    content => template("ovirt/answers.erb"),
  }

  service { 'ovirt-engine':
    enable => true,
    ensure => 'running',
    require => Package[ovirt-engine],
  }

  exec { 'engine-setup':
    require => [ Package[ovirt-engine],
                 File[$answers_file],
    ],
    refreshonly => true,
    path => "/usr/bin/:/bin/:/sbin:/usr/sbin",
    command => "yes 'Yes' | engine-setup --config-append=$answers_file",
    notify => Service[ovirt-engine],
  }
}

