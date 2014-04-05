#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::fastdraw::config {
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
}

# vim:sw=2:ts=2:expandtab
