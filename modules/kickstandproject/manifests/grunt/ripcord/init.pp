#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord::init {
  class { 'kickstandproject::grunt::ripcord::config': }
  class { 'kickstandproject::grunt::ripcord::database': }
  class { 'kickstandproject::grunt::ripcord::install': }
  class { 'kickstandproject::grunt::ripcord::service': }
}

# vim:sw=2:ts=2:expandtab
