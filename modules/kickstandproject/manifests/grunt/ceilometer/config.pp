#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ceilometer::config {
  class { '::ceilometer':
    metering_secret => 'secret',
  }
  class { '::ceilometer::keystone::auth':
    admin_address    => $::ipaddress,
    internal_address => $::ipaddress,
    password         => 'ceilometer',
    public_address   => $::ipaddress,
  }
  class { '::ceilometer::collector': }
  class { '::ceilometer::api':
    keystone_pasword => 'ceilometer',
  }
}

# vim:sw=2:ts=2:expandtab
