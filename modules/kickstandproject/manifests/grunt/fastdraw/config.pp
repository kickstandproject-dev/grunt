#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::fastdraw::config(
  $db_host = $::database_host,
  $db_name = $::fastdraw_db_name,
  $db_password = $::fastdraw_db_password,
  $db_type = $::database_type,
  $db_user = $::fastdraw_db_user,
) {
  user { 'fastdraw':
    ensure     => present,
    home       => '/var/lib/fastdraw',
    managehome => true,
    system     => true,
  }

  file { '/etc/fastdraw':
    ensure  => directory,
    group   => 'fastdraw',
    mode    => '0644',
    owner   => 'fastdraw',
    purge   => true,
    recurse => true,
    require => [
      Class['kickstandproject::grunt::fastdraw::install'],
      User['fastdraw'],
    ],
  }

  file { '/etc/fastdraw/fastdraw.conf':
    ensure  => link,
    group   => 'fastdraw',
    mode    => '0644',
    notify  => Class['kickstandproject::grunt::fastdraw::service'],
    owner   => 'fastdraw',
    require => [
      File['/etc/fastdraw'],
    ],
    target  => '/opt/kickstandproject/fastdraw/etc/fastdraw/fastdraw.conf.sample',
  }

  exec { 'fastdraw-manage db-sync':
    notify      => Class['kickstandproject::grunt::fastdraw::service'],
    refreshonly => true,
    require     => Class['kickstandproject::grunt::fastdraw::database'],
    subscribe   => [
      File['/etc/fastdraw/fastdraw.conf'],
    ],
  }

}

# vim:sw=2:ts=2:expandtab
