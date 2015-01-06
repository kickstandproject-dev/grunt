#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::init {
  class { 'kickstandproject::grunt::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::grunt::backblast::init': }
  class { 'kickstandproject::grunt::ceilometer::init': }
  class { 'kickstandproject::grunt::database': }
  class { 'kickstandproject::grunt::dependencies': }
  class { 'kickstandproject::grunt::fastdraw::init': }
  class { 'kickstandproject::grunt::keystone': }
  class { 'kickstandproject::grunt::payload::init': }
  class { 'kickstandproject::grunt::ripcord::init': }
  class { 'kickstandproject::grunt::swap':}
  class { 'kickstandproject::grunt::wildcard::init': }
}

# vim:sw=2:ts=2:expandtab
