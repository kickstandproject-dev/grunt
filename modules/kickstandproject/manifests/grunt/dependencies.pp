#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::dependencies {
  $packages = [
    'build-essential',
    'libffi-dev',
    'libxml2-dev',
    'libxslt1-dev',
    'python-dev',
  ]

  package { $packages:
    ensure => present,
  }
}

# vim:sw=2:ts=2:expandtab
