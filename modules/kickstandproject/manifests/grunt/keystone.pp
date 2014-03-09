#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::keystone(
  $db_host = '127.0.0.1',
  $db_name = 'keystone',
  $db_password = 'keystone',
  $db_user = 'keystone',
) {

  $sql_conn = "mysql://${db_user}:${db_password}@${db_host}/${db_name}"

  class { '::keystone':
    admin_token    => 'ADMIN',
    sql_connection => $sql_conn,
  }

  class { '::keystone::roles::admin':
    admin_tenant => 'grunt',
    email        => 'grunt@localhost',
    password     => 'grunt',
  }

  class { '::keystone::endpoint':
    admin_address    => $::ipaddress,
    internal_address => $::ipaddress,
    public_address   => $::ipaddress,
  }

  class { '::keystone::db::mysql':
    dbname   => $db_name,
    host     => $db_host,
    password => $db_password,
    user     => $db_user, 
  }
}

# vim:sw=2:ts=2:expandtab
