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
    key         => '4BD6EC30',
    key_content => template('kickstandproject/keys/4BD6EC30.gpg.erb'),
    location    => 'http://apt.puppetlabs.com',
    repos       => 'main',
    require     => File['/etc/apt/preferences.d/00-puppet.pref'],
  }

  file { '/etc/apt/preferences.d/00-puppet.pref':
    ensure => file,
    group  => 'root',
    mode   => '0644',
    owner  => 'root',
    source => 'puppet:///modules/kickstandproject/grunt/etc/apt/preferences.d/00-puppet.pref',
  }

  apt::source { 'Canonical-Cloud-Archive':
    key         => 'EC4926EA',
    key_content => template('kickstandproject/keys/EC4926EA.gpg.erb'),
    location    => 'http://ubuntu-cloud.archive.canonical.com/ubuntu',
    release     => 'precise-updates/havana',
    repos       => 'main',
  }

  apt::source { 'ksp-apus-unstable':
    key      => '5DBF1F7B',
    repos    => 'main',
    location => 'http://ppa.launchpad.net/ksp-apus/unstable/ubuntu',
  }

  host { 'grunt':
    ensure => present,
    ip     => '127.0.0.1',
  }
}

# vim:sw=2:ts=2:expandtab
