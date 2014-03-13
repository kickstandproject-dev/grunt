#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::database {
  class { 'mysql::server': }

  mysql::db { 'ripcord':
    password => 'ripcord',
    require  => Class['mysql::server'],
    user     => 'ripcord',
  }
}

# vim:sw=2:ts=2:expandtab
