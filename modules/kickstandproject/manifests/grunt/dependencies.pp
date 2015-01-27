#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::dependencies {
  $packages = [
    'build-essential',
    'libffi-dev',
    'libxml2-dev',
    'libxslt1-dev',
    'python-dev',
    'python-oslo.config',
    'python-pip',
    'rabbitmq-server',
    'redis-server',
  ]

  package { $packages:
    ensure => present,
  }

  # TODO(pabelanger): Workaround dependency issues with system and user
  # version of oslo.config.
  file { '/usr/local/lib/python2.7/dist-packages/oslo':
    ensure => directory,
  }

  file { '/usr/local/lib/python2.7/dist-packages/oslo/config':
    ensure  => link,
    require => [
      File['/usr/local/lib/python2.7/dist-packages/oslo'],
      Package['python-oslo.config'],
    ],
    target  => '/usr/lib/python2.7/dist-packages/oslo/config',
  }
}

# vim:sw=2:ts=2:expandtab
