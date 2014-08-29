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
    'python-pip',
  ]

  package { $packages:
    ensure => present,
  }

  # NOTE(pabelanger): Because of a bug with python-keystoneclient we need to
  # pin requests to 2.3.0. Besure to remove this code when
  # https://bugs.launchpad.net/python-keystoneclient/+bug/1363179 is resolved. 
  package { 'requests':
    ensure   => '2.3.0',
    provider => pip,
    require  => Package[$packages],
  }
}

# vim:sw=2:ts=2:expandtab
