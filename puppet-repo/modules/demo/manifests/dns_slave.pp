# Class: demo::dns_slave
#
#
class demo::dns_slave {
  class {'bind': chroot => true}

  bind::server::conf { '/etc/named.conf':
    listen_on_addr    => ['any'],
    listen_on_v6_addr => ['any'],
    allow_query       => ['any'],
    zones             => {
      'example.com' => [
        'type slave',
        'file "example.com"',
        'masters {172.22.0.23;}'
      ]
    }
  }

  bind::server::file { 'named.ca':
    zonedir => '/var/named/chroot/var/named',
    source => 'puppet:///modules/demo/named.ca'
  }

  bind::server::file { 'named.empty':
    zonedir => '/var/named/chroot/var/named',
    source => 'puppet:///modules/demo/named.empty'
  }

  bind::server::file { 'named.localhost':
    zonedir => '/var/named/chroot/var/named',
    source => 'puppet:///modules/demo/named.localhost'
  }

  bind::server::file { 'named.loopback':
    zonedir => '/var/named/chroot/var/named',
    source => 'puppet:///modules/demo/named.loopback'
  }

  file { '/var/named/chroot/var/named/dynamic':
    owner  => 'named',
    group  => 'named',
    mode   => '0770',
    ensure => 'directory',
    require => Package['bind-chroot'],
    before => Service['named']
  }
}