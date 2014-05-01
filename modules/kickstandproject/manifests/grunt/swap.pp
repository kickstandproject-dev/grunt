#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::grunt::swap(
  $stage = 'bootstrap',
) {
  case $::swapsize_mb {
    '0.00': {
      exec { 'Create swap file':
        command => 'dd if=/dev/zero of=/mnt/swap.1 bs=1M count=2048',
        creates => '/mnt/swap.1',
        notify  => Exec['Make swap file'],
      }

      exec { 'Make swap file':
        command     => 'mkswap /mnt/swap.1 && swapon /mnt/swap.1',
        notify      => File['/etc/cron.d/swapon'],
        refreshonly => true,
      }

      file { '/etc/cron.d/swapon':
        ensure  => file,
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
        require => Exec['Create swap file'],
        source  => 'puppet:///modules/kickstandproject/grunt/etc/cron.d/swapon',
      }
    }
    default: {}
  }
}

# vim:sw=2:ts=2:expandtab
