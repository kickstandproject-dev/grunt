#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::wildcard(
  $revision = 'master',
  $source = 'https://github.com/kickstandproject/wildcard.git',
) {
  vcsrepo { '/opt/kickstandproject/wildcard':
    ensure   => latest,
    provider => git,
    revision => $revision,
    source   => $source,
  }
}

# vim:sw=2:ts=2:expandtab
