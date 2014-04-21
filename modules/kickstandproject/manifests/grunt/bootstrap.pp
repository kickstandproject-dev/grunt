#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::bootstrap(
  $stage = 'bootstrap',
) {
  class { 'apt': }

  apt::source { 'puppetlabs':
    key      => '4BD6EC30',
    location => 'http://apt.puppetlabs.com',
    repos    => 'main',
    require  => File['/etc/apt/preferences.d/00-puppet.pref'],
  }

  file { '/etc/apt/preferences.d/00-puppet.pref':
    ensure => file,
    group  => 'root',
    mode   => '0644',
    owner  => 'root',
    source => 'puppet:///modules/kickstandproject/grunt/etc/apt/preferences.d/00-puppet.pref',
  }

  apt::source { 'Canonical-Cloud-Archive':
    key      => 'EC4926EA',
    location => 'ubuntu-cloud.archive.canonical.com/ubuntu',
    release  => 'precise-updates/havana',
    repos    => 'main',
  }
}

# vim:sw=2:ts=2:expandtab
