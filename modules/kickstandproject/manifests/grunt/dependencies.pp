#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::dependencies {
  $packages = [
    'build-essential',
    'libffi-dev',
    'python-dev',
    'python-pip',
  ]

  package { $packages:
    ensure => present,
  }

  package { 'pip':
    ensure   => '1.4',
    provider => pip,
    require  => Package[$packages],
  }
}

# vim:sw=2:ts=2:expandtab
