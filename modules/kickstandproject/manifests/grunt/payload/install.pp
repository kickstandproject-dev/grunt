#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::payload::install(
  $path = '/opt/kickstandproject/payload',
  $revision = $::payload_branch,
  $source = $::payload_repo,
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

  file { '/etc/init/payload-api.conf':
    ensure => file,
    source => 'puppet:///modules/kickstandproject/payload/etc/init/payload-api.conf',
  }
}

# vim:sw=2:ts=2:expandtab
