#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ceilometer::init {
  class { 'kickstandproject::grunt::ceilometer::config': }
  class { 'kickstandproject::grunt::ceilometer::database': }
}

# vim:sw=2:ts=2:expandtab
