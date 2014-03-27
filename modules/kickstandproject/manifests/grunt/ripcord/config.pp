#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord::config {
  user { 'ripcord':
    ensure     => present,
    home       => '/var/lib/ripcord',
    managehome => true,
    system     => true,
  }

  file { '/etc/ripcord':
    ensure  => directory,
    group   => 'ripcord',
    mode    => '0644',
    owner   => 'ripcord',
    purge   => true,
    recurse => true,
    require => [
      Class['kickstandproject::grunt::ripcord::install'],
      User['ripcord'],
    ],
  }

  file { '/etc/ripcord/ripcord.conf':
    ensure  => link,
    group   => 'ripcord',
    mode    => '0644',
    notify  => Class['kickstandproject::grunt::ripcord::service'],
    owner   => 'ripcord',
    require => [
      File['/etc/ripcord'],
    ],
    target  => '/opt/kickstandproject/ripcord/etc/ripcord/ripcord.conf.sample',
  }

  ini_setting { 'keystone_authtoken/admin_password':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::ripcord::service'],
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/ripcord.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_password',
    value   => 'ripcord',
  }

  ini_setting { 'keystone_authtoken/admin_tenant_name':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::ripcord::service'],
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/ripcord.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_tenant_name',
    value   => 'services',
  }

  ini_setting { 'keystone_authtoken/admin_user':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::ripcord::service'],
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/ripcord.conf'],
    section => 'keystone_authtoken',
    setting => 'admin_user',
    value   => 'ripcord',
  }

  ini_setting { 'keystone_authtoken/auth_host':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::ripcord::service'],
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/ripcord.conf'],
    section => 'keystone_authtoken',
    setting => 'auth_host',
    value   => $::ipaddress,
  }

  ini_setting { 'keystone_authtoken/auth_protocol':
    ensure  => present,
    notify  => Class['kickstandproject::grunt::ripcord::service'],
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/ripcord.conf'],
    section => 'keystone_authtoken',
    setting => 'auth_protocol',
    value   => 'http',
  }

  ini_setting { 'connection':
    ensure  => present,
    before  => Exec['ripcord-manage db-sync'],
    notify  => [
      Class['kickstandproject::grunt::ripcord::service'],
      Exec['ripcord-manage db-sync'],
    ],
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/ripcord.conf'],
    section => 'database',
    setting => 'connection',
    value   => 'mysql://ripcord:ripcord@localhost/ripcord',
  }

  exec { 'ripcord-manage db-sync':
    notify      => Class['kickstandproject::grunt::ripcord::service'],
    refreshonly => true,
    require     => Class['kickstandproject::grunt::database'],
    subscribe   => [
      File['/etc/ripcord/ripcord.conf'],
    ],
  }

  keystone_service { 'ripcord':
    ensure      => present,
    description => 'Kickstand Project SIP Service',
    type        => 'sip',
  }

  keystone_endpoint { 'RegionOne/ripcord':
    ensure       => present,
    admin_url    => "http://${::ipaddress}:9869",
    internal_url => "http://${::ipaddress}:9869",
    public_url   => "http://${::ipaddress}:9869",
    region       => 'RegionOne',
  }

  keystone_user { 'ripcord':
    ensure   => present,
    enabled  => true,
    tenant   => 'services',
    email    => 'ripcord@localhost',
    password => 'ripcord',
  }

  keystone_user_role { 'ripcord@services':
    ensure => present,
    roles  => 'admin',
  }
}

# vim:sw=2:ts=2:expandtab
