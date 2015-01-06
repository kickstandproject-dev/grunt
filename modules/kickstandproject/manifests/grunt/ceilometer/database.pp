#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ceilometer::database(
  $db_host = $::database_host,
  $db_name = $::ceilometer_db_name,
  $db_password = $::ceilometer_db_password,
  $db_type = $::database_type,
  $db_user = $::ceilometer_db_user,
) {

  $sql_conn = "${db_type}://${db_user}:${db_password}@${db_host}/${db_name}"

  if ($db_type == 'mysql') {
    class { '::ceilometer::db::mysql':
      dbname   => $db_name,
      host     => $db_host,
      password => $db_password,
      user     => $db_user,
    }
  } else {
    require kickstandproject::grunt::database

    postgresql::db { $db_name:
      password => $db_password,
      user     => $db_user,
    }
  }

  class { '::ceilometer::db':
    database_connection => $sql_conn,
  }
}

# vim:sw=2:ts=2:expandtab
