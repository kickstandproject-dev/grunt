#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord::service(
) {
  service { 'ripcord-api':
    ensure => running,
    require => [
      Class['kickstandproject::grunt::ripcord::config'],
      File['/etc/init/ripcord-api.conf'],
    ],
  }
}

# vim:sw=2:ts=2:expandtab
