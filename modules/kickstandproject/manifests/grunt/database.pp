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

    mysql::db { 'ripcord':
      password => 'ripcord',
      require  => Class['mysql::server'],
      user     => 'ripcord',
    }
  }
}

# vim:sw=2:ts=2:expandtab
