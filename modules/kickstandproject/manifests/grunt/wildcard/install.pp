#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::wildcard::install(
  $path = '/opt/kickstandproject/wildcard',
  $revision = 'master',
  $source = 'https://github.com/kickstandproject/wildcard.git',
) {
  vcsrepo { $path:
    ensure   => latest,
    notify   => Exec["pip install -e $path"],
    provider => git,
    revision => $revision,
    source   => $source,
  }

  exec { "pip install -e $path":
    refreshonly => true,
  }
}

# vim:sw=2:ts=2:expandtab
