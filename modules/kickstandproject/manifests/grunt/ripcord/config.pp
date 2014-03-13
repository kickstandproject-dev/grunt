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
    mode    => 0644,
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

  ini_setting { 'auth_strategy':
    ensure  => present,
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/ripcord.conf'],
    section => 'DEFAULT',
    setting => 'auth_strategy',
    value   => 'noauth',
  }

  ini_setting { 'connection':
    ensure  => present,
    before  => Exec['ripcord-manage db-sync'],
    notify  => Exec['ripcord-manage db-sync'],
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
}

# vim:sw=2:ts=2:expandtab
