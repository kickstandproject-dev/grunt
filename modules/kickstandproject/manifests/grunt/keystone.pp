#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::keystone(
  $db_host = $::keystone_db_host,
  $db_name = $::keystone_db_name,
  $db_password = $::keystone_db_password,
  $db_type = $::keystone_db_type,
  $db_user = $::keystone_db_user,
  $grunt_email = $::keystone_grunt_email,
  $grunt_password = $::keystone_grunt_password,
  $grunt_tenant = $::keystone_grunt_tenant,
  $grunt_user = $::keystone_grunt_user,
) {

  $sql_conn = "${db_type}://${db_user}:${db_password}@${db_host}/${db_name}"

  if ($db_type == 'mysql') {
    class { '::keystone::db::mysql':
      dbname   => $db_name,
      host     => $db_host,
      password => $db_password,
      user     => $db_user,
    }
  }

  class { '::keystone':
    admin_token    => 'ADMIN',
    sql_connection => $sql_conn,
  }->
  class { '::keystone::roles::admin':
    admin_tenant => 'admin',
    email        => 'admin@localhost',
    password     => 'admin',
  }->
  class { '::keystone::endpoint':
    admin_address    => $::ipaddress,
    internal_address => $::ipaddress,
    public_address   => $::ipaddress,
  }

  keystone_tenant { $grunt_tenant:
    ensure      => present,
    enabled     => true,
    description => 'Tenant for Kickstand Project Grunt',
  }

  keystone_user { $grunt_user:
    ensure   => present,
    enabled  => true,
    tenant   => $grunt_tenant,
    email    => 'grunt@localhost',
    password => $grunt_password,

  }

  keystone_user_role { "${grunt_user}@${grunt_tenant}":
    ensure => present,
    roles  => '_member_',
  }
}

# vim:sw=2:ts=2:expandtab
