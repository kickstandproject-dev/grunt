#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::database {
  class { 'mysql::server': }
}

# vim:sw=2:ts=2:expandtab
