#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::asterisk::init {
  class { 'kickstandproject::grunt::asterisk::config': }
  class { 'kickstandproject::grunt::asterisk::install': }
}

# vim:sw=2:ts=2:expandtab
