#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::backblast::install(
  $path = '/opt/kickstandproject/backblast',
  $revision = $::backblast_branch,
  $source = $::backblast_repo,
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
