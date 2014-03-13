#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::ripcord(
  $revision = 'master',
  $source = 'https://github.com/kickstandproject/ripcord.git',
) {
  vcsrepo { '/opt/kickstandproject/ripcord':
    ensure   => latest,
    provider => git,
    revision => $revision,
    source   => $source,
  }
}

# vim:sw=2:ts=2:expandtab
