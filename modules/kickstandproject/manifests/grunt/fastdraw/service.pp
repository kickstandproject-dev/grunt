#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::fastdraw::service(
) {
  service { 'fastdraw-notification':
    ensure  => running,
    require => [
      Class['kickstandproject::grunt::fastdraw::config'],
      File['/etc/init/fastdraw-notification.conf'],
    ],
  }
}

# vim:sw=2:ts=2:expandtab
