#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::backblast::service(
) {
  service { 'backblast-api':
    ensure  => running,
    require => [
      Class['kickstandproject::grunt::backblast::config'],
      File['/etc/init/backblast-api.conf'],
    ],
  }
}

# vim:sw=2:ts=2:expandtab
