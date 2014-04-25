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

  file { '/etc/backblast/backblast.conf':
    ensure  => link,
    group   => 'backblast',
    mode    => '0644',
    notify  => Class['kickstandproject::grunt::backblast::service'],
    owner   => 'backblast',
    require => [
      File['/etc/backblast'],
    ],
    target  => '/opt/kickstandproject/backblast/etc/backblast/backblast.conf.sample',
  }

  ini_setting { 'keystone_authtoken/admin_password':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::backblast::service'],
    path    => '/etc/backblast/backblast.conf',
    require => File['/etc/backblast/backblast.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_password',
    value   => 'backblast',
  }

  ini_setting { 'keystone_authtoken/admin_tenant_name':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::backblast::service'],
    path    => '/etc/backblast/backblast.conf',
    require => File['/etc/backblast/backblast.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_tenant_name',
    value   => 'services',
  }

  ini_setting { 'keystone_authtoken/admin_user':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::backblast::service'],
    path    => '/etc/backblast/backblast.conf',
    require => File['/etc/backblast/backblast.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_user',
    value   => 'backblast',
  }

  ini_setting { 'keystone_authtoken/auth_host':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::backblast::service'],
    path    => '/etc/backblast/backblast.conf',
    require => File['/etc/backblast/backblast.conf'],
    section => 'keystone_authtoken',
    setting => 'auth_host',
    value   => $::ipaddress,
  }

  ini_setting { 'keystone_authtoken/auth_protocol':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::backblast::service'],
    path    => '/etc/backblast/backblast.conf',
    require => File['/etc/backblast/backblast.conf'],
    section => 'keystone_authtoken',
    setting => 'auth_protocol',
    value   => 'http',
  }

  ini_setting { 'connection':
    ensure  => present,
    before  => Exec['backblast-manage db-sync'],
    notify  => [
      Class['kickstandproject::grunt::backblast::service'],
      Exec['backblast-manage db-sync'],
    ],
    path    => '/etc/backblast/backblast.conf',
    require => File['/etc/backblast/backblast.conf'],
    section => 'database',
    setting => 'connection',
    value   => 'mysql://backblast:backblast@localhost/backblast',
  }

  exec { 'backblast-manage db-sync':
    notify      => Class['kickstandproject::grunt::backblast::service'],
    refreshonly => true,
    require     => Class['kickstandproject::grunt::database'],
    subscribe   => [
      File['/etc/backblast/backblast.conf'],
    ],
  }

  keystone_service { 'backblast':
    ensure      => present,
    description => 'Kickstand Project Notification Service',
    type        => 'sip',
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
