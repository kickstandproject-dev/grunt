#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::wildcard::install(
  $path = '/opt/kickstandproject/wildcard',
  $revision = $::wildcard_branch,
  $source = $::wildcard_repo,
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
    notify   => Exec["pip install -e ${path}"],
    owner    => 'wildcard',
    provider => git,
    require  => User['wildcard'],
    revision => $revision,
    source   => $source,
  }

  exec { "pip install -e ${path}":
    refreshonly => true,
    require     => Package['python-pip'],
  }
}

# vim:sw=2:ts=2:expandtab
