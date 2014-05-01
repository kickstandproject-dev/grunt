#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::payload::init {
  class { 'kickstandproject::grunt::payload::config': }
  class { 'kickstandproject::grunt::payload::install': }
  class { 'kickstandproject::grunt::payload::service': }
}

# vim:sw=2:ts=2:expandtab
