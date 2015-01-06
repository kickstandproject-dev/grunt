#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ceilometer::init {
  class { '::ceilometer::keystone::auth':
    admin_address    => $::ipaddress,
    internal_address => $::ipaddress,
    password         => 'ceilometer',
    public_address   => $::ipaddress,
  }->
  class { '::ceilometer::collector': }
}

# vim:sw=2:ts=2:expandtab
