#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::payload::service(
) {
  service { 'payload-api':
    ensure  => running,
    require => [
      Class['kickstandproject::grunt::payload::config'],
      File['/etc/init/payload-api.conf'],
    ],
  }
}

# vim:sw=2:ts=2:expandtab
