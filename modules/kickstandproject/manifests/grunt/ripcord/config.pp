#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord::config {
  user { 'ripcord':
    ensure => present,
    system => true,
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
    owner   => 'ripcord',
    require => File['/etc/ripcord'],
    target  => '/opt/kickstandproject/ripcord/etc/ripcord/ripcord.conf.sample',
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
    refreshonly => true,
    require     => Class['kickstandproject::grunt::database'],
    subscribe   => [
      File['/etc/ripcord/ripcord.conf'],
      Vcsrepo['/opt/kickstandproject/ripcord'],
    ],
  }
}

# vim:sw=2:ts=2:expandtab
