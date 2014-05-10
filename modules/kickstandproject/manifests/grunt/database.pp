#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::database(
  $host = $::database_host,
  $type = $::database_type,
) {
  if ($type == 'mysql') {
    class { 'mysql::server':
      config_hash => {
        'bind_address' => $host,
      },
    }
  } else {
    class { 'postgresql::server':
      'listen_addresses' => $host,
    }
  }
}

# vim:sw=2:ts=2:expandtab
