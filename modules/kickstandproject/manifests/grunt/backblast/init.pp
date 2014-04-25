#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::backblast::init {
  class { 'kickstandproject::grunt::backblast::config': }
  class { 'kickstandproject::grunt::backblast::install': }
  class { 'kickstandproject::grunt::backblast::service': }
}

# vim:sw=2:ts=2:expandtab
