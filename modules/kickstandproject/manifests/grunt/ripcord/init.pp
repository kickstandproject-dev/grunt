#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord::init {
  class { 'kickstandproject::grunt::ripcord::config': }
  class { 'kickstandproject::grunt::ripcord::install': }
}

# vim:sw=2:ts=2:expandtab
