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

  class { '::keystone::db::mysql':
    dbname   => $db_name,
    host     => $db_host,
    password => $db_password,
    user     => $db_user,
  }

  class { '::keystone':
    admin_token    => 'ADMIN',
    require        => Class['::keystone::db::mysql'],
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

  # Create and assign 'grunt' user to 'grunt' project with '_member_' permissions.
  keystone_tenant { 'grunt':
    ensure      => present,
    enabled     => true,
    description => 'Tenant for Kickstand Project Grunt',
  }

  keystone_user { 'grunt':
    ensure   => present,
    enabled  => true,
    tenant   => 'grunt',
    email    => 'grunt@localhost',
    password => 'grunt',

  }

  keystone_user_role { 'grunt@grunt':
    ensure => present,
    roles  => '_member_',
  }
}

# vim:sw=2:ts=2:expandtab
