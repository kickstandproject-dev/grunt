#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::backblast::config {
  user { 'backblast':
    ensure     => present,
    home       => '/var/lib/backblast',
    managehome => true,
    system     => true,
  }

  file { '/etc/backblast':
    ensure  => directory,
    group   => 'backblast',
    mode    => '0644',
    owner   => 'backblast',
    purge   => true,
    recurse => true,
    require => [
      Class['kickstandproject::grunt::backblast::install'],
      User['backblast'],
    ],
  }

  keystone_service { 'backblast':
    ensure      => present,
    description => 'Kickstand Project Notification Service',
    type        => 'notification',
  }

  keystone_endpoint { 'RegionOne/backblast':
    ensure       => present,
    admin_url    => "http://${::ipaddress}:9869",
    internal_url => "http://${::ipaddress}:9869",
    public_url   => "http://${::ipaddress}:9869",
    region       => 'RegionOne',
  }

  keystone_user { 'backblast':
    ensure   => present,
    enabled  => true,
    tenant   => 'services',
    email    => 'backblast@localhost',
    password => 'backblast',
  }

  keystone_user_role { 'backblast@services':
    ensure => present,
    roles  => 'admin',
  }
}

# vim:sw=2:ts=2:expandtab
