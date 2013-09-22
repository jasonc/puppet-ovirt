ovirt
=====

Table of Contents
-----------------

1. [Overview - What is the oVirt module?](#overview)
2. [Module Description - What the ovirt module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with ovirt](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - The classes, defines,functions and facts available in this module](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)


Overview
--------

The oVirt module allows you to easily install oVirt engine and oVirt node with Puppet.


Module Description
-------------------

oVirt is a virtualization management application. That means that you can use the oVirt management interface (the oVirt engine) to manage hardware nodes, storage and network resources, and to deploy and monitor virtual machines running in your data center.  The ovirt module allows you to install the oVirt Engine (management host) and oVirt Node (hyperviser host) software on RedHat-based distros.


Setup
-----

**Setup Requirements:**

RHEL and CentOS hosts need to have EPEL configured in order to fulfill oVirt rpm dependencies.

###Configuring the oVirt Engine

The only configuration you may need to perform will be around the `ovirt::engine` class.  The default parameters are reasonable for a simple and common configuration. To manage an oVirt Engine with defaults:

    class { 'ovirt::engine': }

Parameters can be passed in for a more customized configuration:

    class { 'ovirt::engine':
      storageType => 'fc',
    }

Once you have completed the configuration of `ovirt::engine`, you can test the settings by visiting the web management interface in a web browser and logging in as admin@internal with the default password of admin.

###Configuring the oVirt Node

    class { 'ovirt::node': }


Usage
-----

###Creating an oVirt Engine

To create an oVirt Engine:

    class { 'ovirt::engine': }

###Creating an oVirt Node

To create an oVirt Node:

    class { 'ovirt::node': }

At this point, you are able to add the node to a host cluster using an oVirt Engine.


Reference
---------

The ovirt module comes with several options for configuring the oVirt engine.

Classes:

* [ovirt::engine](#class-ovirtengine)
* [ovirt::node](#class-ovirtnode)


###Class: ovirt::engine
This class allows you to configure the main settings for an oVirt Engine.

For example, if you want to use iSCSI for the default storage type in the default data center, you could do this:

    class { 'ovirt::engine':
      storageType => 'iscsi',
    }

####`applicationMode`
This setting can be used to override the default ovirt application mode of both.  Valid options are both, virt, gluster.

####`storageType`
This setting can be used to override the default ovirt storage type of nfs.  Valid options are nfs, fc, iscsi, and posixfs.

####`organization`
This setting can be used to override the default ovirt PKI organization of localdomain.

####`nfsConfigEnabled`
This setting can be used to override the default ovirt nfs configuration of true.  Valid options are true and false.

####`isoDomainName`
This setting can be used to override the default ISO Domain Name of ISO_DOMAIN.

####`isoDomainMountPoint`
This setting can be used to override the default ISO Domain Mount Point of /var/lib/exports/iso.

####`adminPassword`
This setting can be used to override the default ovirt admin password of admin.

####`dbPassword`
This setting can be used to override the default database password of dbpassword.

####`dbHost`
This setting can be used to override the default database host of localhost.

####`dbPort`
This setting can be used to override the default database port of 5432.

####`firewallManager`
This setting can be used to override the default firewall manager.  The module uses iptables for RHEL and CentOS and firewalld for Fedora by default.  Valid options are iptables and firewalld.


Limitations
------------

This module is known to work with oVirt 3.3.  Other versions of oVirt have not been tested.


Development
------------

GitHub: <https://github.com/jasonc/puppet-ovirt>

Puppet Forge: <http://forge.puppetlabs.com/jcannon/ovirt>.

