#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::payload(
  $revision = 'master',
  $source = 'https://github.com/kickstandproject/payload.git',
) {
  vcsrepo { '/opt/kickstandproject/payload':
    ensure   => latest,
    provider => git,
    revision => $revision,
    source   => $source,
  }
}

# vim:sw=2:ts=2:expandtab
