#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::wildcard::init {
  class { 'kickstandproject::grunt::wildcard::config': }
  class { 'kickstandproject::grunt::wildcard::install': }
}

# vim:sw=2:ts=2:expandtab
