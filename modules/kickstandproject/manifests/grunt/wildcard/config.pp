#
# Copyright (C) 2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::wildcard::config {
  class { 'apache':
    default_vhost => false,
  }

  class { 'apache::mod::wsgi': }

  apache::vhost { 'wildcard':
    docroot                     => '/var/www/wildcard',
    port                        => '80',
    wsgi_daemon_process         => 'wsgi',
    wsgi_daemon_process_options => {
      processes => '2',
      threads   => '15',
    },
    wsgi_process_group          => 'wsgi',
    wsgi_script_aliases         => {
      '/' => '/opt/kickstandproject/wildcard/wildcard/wsgi/django.wsgi',
    },
  }

  user { 'wildcard':
    ensure     => present,
    home       => '/var/lib/wildcard',
    managehome => true,
    system     => true,
  }

  file { '/etc/wildcard':
    ensure  => directory,
    group   => 'wildcard',
    mode    => 0644,
    owner   => 'wildcard',
    purge   => true,
    recurse => true,
    require => [
      Class['kickstandproject::grunt::wildcard::install'],
      User['wildcard'],
    ],
  }

  file { '/etc/wildcard/local_settings.py':
    ensure  => link,
    group   => 'wildcard',
    mode    => '0644',
    notify  => Class['kickstandproject::grunt::wildcard::service'],
    owner   => 'wildcard',
    require => File['/etc/wildcard'],
    target  => '/opt/kickstandproject/wildcard/wildcard/local/local_settings.py.example',
  }
}

# vim:sw=2:ts=2:expandtab
