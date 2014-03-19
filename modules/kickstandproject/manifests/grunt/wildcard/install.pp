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
  user { 'wildcard':
    ensure     => present,
    home       => '/var/lib/wildcard',
    managehome => true,
    system     => true,
  }

  vcsrepo { $path:
    ensure   => latest,
    group    => 'wildcard',
    notify   => Exec['pip install wildcard'],
    owner    => 'wildcard',
    provider => git,
    require  => User['wildcard'],
    revision => $revision,
    source   => $source,
  }

  exec { 'pip install wildcard':
    command     => "pip install --process-dependency-links -e $path",
    refreshonly => true,
  }
}

# vim:sw=2:ts=2:expandtab
