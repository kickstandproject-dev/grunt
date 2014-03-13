#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::init {
  class { 'kickstandproject::grunt::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::grunt::database': }
  class { 'kickstandproject::grunt::dependencies': }
  class { 'kickstandproject::grunt::keystone': }
  class { 'kickstandproject::grunt::ripcord': }
}

# vim:sw=2:ts=2:expandtab
