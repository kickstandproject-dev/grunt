#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::payload::database(
  $db_host = $::database_host,
  $db_name = $::payload_db_name,
  $db_password = $::payload_db_password,
  $db_type = $::database_type,
  $db_user = $::payload_db_user,
) {
  require kickstandproject::grunt::payload::config
  require kickstandproject::grunt::database

  if ($db_type == 'mysql') {
    mysql::db { $db_name:
      password => $db_password,
      user     => $db_user,
    }
  }

  ini_setting { 'payload/database/connection':
    ensure  => present,
    before  => Exec['payload-manage db-sync'],
    notify  => [
      Class['kickstandproject::grunt::payload::service'],
      Exec['payload-manage db-sync'],
    ],
    path    => '/etc/payload/payload.conf',
    require => File['/etc/payload/payload.conf'],
    section => 'database',
    setting => 'connection',
    value   => "${db_type}://${db_user}:${db_password}@${db_host}/${db_name}",
  }
}

# vim:sw=2:ts=2:expandtab
