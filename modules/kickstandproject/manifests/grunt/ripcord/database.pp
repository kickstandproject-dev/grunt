#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord::database(
  $db_host = $::database_host,
  $db_name = $::ripcord_db_name,
  $db_password = $::ripcord_db_password,
  $db_type = $::database_type,
  $db_user = $::ripcord_db_user,
) {
  require kickstandproject::grunt::ripcord::config
  require kickstandproject::grunt::database

  if ($db_type == 'mysql') {
    mysql::db { $db_name:
      password => $db_password,
      user     => $db_user,
    }
  }

  ini_setting { 'ripcord/database/connection':
    ensure  => present,
    before  => Exec['ripcord-manage db-sync'],
    notify  => [
      Class['kickstandproject::grunt::ripcord::service'],
      Exec['ripcord-manage db-sync'],
    ],
    path    => '/etc/ripcord/ripcord.conf',
    require => File['/etc/ripcord/payload.conf'],
    section => 'database',
    setting => 'connection',
    value   => "${db_type}://${db_user}:${db_password}@${db_host}/${db_name}",
  }
}

# vim:sw=2:ts=2:expandtab
