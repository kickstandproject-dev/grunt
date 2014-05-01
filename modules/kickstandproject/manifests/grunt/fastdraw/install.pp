#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::fastdraw::install(
  $path = '/opt/kickstandproject/fastdraw',
  $revision = $::fastdraw_branch,
  $source = $::fastdraw_repo,
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
    require     => Class[kickstandproject::grunt::dependencies],
  }
}

# vim:sw=2:ts=2:expandtab
