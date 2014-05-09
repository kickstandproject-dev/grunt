#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::payload::config(
  $db_host = $::database_host,
  $db_name = $::payload_db_name,
  $db_password = $::payload_db_password,
  $db_type = $::database_type,
  $db_user = $::payload_db_user,
) {
  user { 'payload':
    ensure     => present,
    home       => '/var/lib/payload',
    managehome => true,
    system     => true,
  }

  file { '/etc/payload':
    ensure  => directory,
    group   => 'payload',
    mode    => '0644',
    owner   => 'payload',
    purge   => true,
    recurse => true,
    require => [
      Class['kickstandproject::grunt::payload::install'],
      User['payload'],
    ],
  }

  file { '/etc/payload/payload.conf':
    ensure  => link,
    group   => 'payload',
    mode    => '0644',
    notify  => Class['kickstandproject::grunt::payload::service'],
    owner   => 'payload',
    require => [
      File['/etc/payload'],
    ],
    target  => '/opt/kickstandproject/payload/etc/payload/payload.conf.sample',
  }

  ini_setting { 'payload/keystone_authtoken/admin_password':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::payload::service'],
    path    => '/etc/payload/payload.conf',
    require => File['/etc/payload/payload.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_password',
    value   => 'payload',
  }

  ini_setting { 'payload/keystone_authtoken/admin_tenant_name':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::payload::service'],
    path    => '/etc/payload/payload.conf',
    require => File['/etc/payload/payload.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_tenant_name',
    value   => 'services',
  }

  ini_setting { 'payload/keystone_authtoken/admin_user':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::payload::service'],
    path    => '/etc/payload/payload.conf',
    require => File['/etc/payload/payload.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_user',
    value   => 'payload',
  }

  ini_setting { 'payload/keystone_authtoken/auth_host':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::payload::service'],
    path    => '/etc/payload/payload.conf',
    require => File['/etc/payload/payload.conf'],
    section => 'keystone_authtoken',
    setting => 'auth_host',
    value   => $::ipaddress,
  }

  ini_setting { 'payload/keystone_authtoken/auth_protocol':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::payload::service'],
    path    => '/etc/payload/payload.conf',
    require => File['/etc/payload/payload.conf'],
    section => 'keystone_authtoken',
    setting => 'auth_protocol',
    value   => 'http',
  }

  ini_setting { 'payload/database/connection':
    ensure  => present,
    before  => Exec['payload-manage db-sync'],
    notify  => [
      Class['kickstandproject::grunt::payload::service'],
      Exec['payload-manage db-sync'],
    ],
    path    => '/etc/payload/payload.conf',
    require => File['/etc/payload/payload.conf'],
    section => 'database',
    setting => 'connection',
    value   => "${db_type}://${db_user}:${db_password}@${db_host}/${db_name}",
  }

  exec { 'payload-manage db-sync':
    notify      => Class['kickstandproject::grunt::payload::service'],
    refreshonly => true,
    require     => Class['kickstandproject::grunt::payload::database'],
    subscribe   => [
      File['/etc/payload/payload.conf'],
    ],
  }

  keystone_service { 'payload':
    ensure      => present,
    description => 'Kickstand Project Queue Service',
    type        => 'queue',
  }

  keystone_endpoint { 'RegionOne/payload':
    ensure       => present,
    admin_url    => "http://${::ipaddress}:9859",
    internal_url => "http://${::ipaddress}:9859",
    public_url   => "http://${::ipaddress}:9859",
    region       => 'RegionOne',
  }

  keystone_user { 'payload':
    ensure   => present,
    enabled  => true,
    tenant   => 'services',
    email    => 'payload@localhost',
    password => 'payload',
  }

  keystone_user_role { 'payload@services':
    ensure => present,
    roles  => 'admin',
  }
}

# vim:sw=2:ts=2:expandtab
