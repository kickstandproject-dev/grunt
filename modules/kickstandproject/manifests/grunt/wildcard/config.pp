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
    aliases                     => [
      {
        alias => '/static',
        path  => '/opt/kickstandproject/wildcard/wildcard/static',
      },
    ],
    docroot                     => '/var/www/wildcard',
    port                        => '80',
    wsgi_daemon_process         => 'wildcard',
    wsgi_daemon_process_options => {
      group     => 'wildcard',
      processes => '3',
      threads   => '10',
      user      => 'wildcard',
    },
    wsgi_process_group          => 'wildcard',
    wsgi_script_aliases         => {
      '/' => '/opt/kickstandproject/wildcard/wildcard/wsgi/django.wsgi',
    },
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
