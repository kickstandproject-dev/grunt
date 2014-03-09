#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::bootstrap(
  $stage = 'bootstrap',
) {
  apt::function::repository { 'puppetlabs':
    components => 'main',
    key        => '4BD6EC30',
    require    => File['/etc/apt/preferences.d/00-puppet.pref'],
    url        => 'apt.puppetlabs.com',
  }

  file { '/etc/apt/preferences.d/00-puppet.pref':
    ensure => file,
    source => 'puppet:///modules/kickstandproject/grunt/etc/apt/preferences.d/00-puppet.pref',
  }

  apt::function::repository { 'Canonical-Cloud-Archive':
    components => 'main',
    dist       => 'precise-updates/havana',
    key        => 'EC4926EA',
    url        => 'ubuntu-cloud.archive.canonical.com/ubuntu',
  }
}

# vim:sw=2:ts=2:expandtab
