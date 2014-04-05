#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::fastdraw::install(
  $path = '/opt/kickstandproject/fastdraw',
  $revision = 'master',
  $source = 'https://github.com/kickstandproject/fastdraw.git',
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
    require     => Package['pip'],
  }
}

# vim:sw=2:ts=2:expandtab
