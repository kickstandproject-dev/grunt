#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord::install(
  $path = '/opt/kickstandproject/ripcord',
  $revision = 'master',
  $source = 'https://github.com/kickstandproject/ripcord.git',
) {
  vcsrepo { $path:
    ensure   => latest,
    notify   => Exec["pip install -e ${path}"],
    provider => git,
    revision => $revision,
    source   => $source,
  }

  exec { "pip install -e ${path}":
    refreshonly => true,
    require     => Package['python-pip'],
  }

  file { '/etc/init/ripcord-api.conf':
    ensure => file,
    source => 'puppet:///modules/kickstandproject/ripcord/etc/init/ripcord-api.conf',
  }
}

# vim:sw=2:ts=2:expandtab
