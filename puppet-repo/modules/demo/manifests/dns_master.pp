# Class: demo::dns_master
#
#
class demo::dns_master {
  class {'bind': chroot => true}

  bind::server::conf { '/etc/named.conf':
    listen_on_addr    => ['any'],
    listen_on_v6_addr => ['any'],
    allow_query       => ['any'],
    zones             => {
      'example.com' => [
        'type master',
        'file "example.com"'
      ]
    }
  }

  bind::server::file { 'example.com':
    zonedir => '/var/named/chroot/var/named',
    content => template("demo/example.com.erb")
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
}