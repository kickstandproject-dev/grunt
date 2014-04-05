#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::fastdraw::init {
  class { 'kickstandproject::grunt::fastdraw::config': }
  class { 'kickstandproject::grunt::fastdraw::install': }
}

# vim:sw=2:ts=2:expandtab
