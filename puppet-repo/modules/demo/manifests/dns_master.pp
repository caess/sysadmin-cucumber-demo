# Class: demo::dns_master
#
#
class demo::dns_master {
  # For BIND
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
    owner   => 'vagrant',
    group   => 'named',
    mode    => '0640',
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

  file { '/var/named/chroot/var/named/dynamic':
    owner  => 'named',
    group  => 'named',
    mode   => '0770',
    ensure => 'directory',
    require => Package['bind-chroot'],
    before => Service['named']
  }

  # For tests
  file { '/home/vagrant/set_txt_record':
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0700',
    ensure => 'file',
    source => 'puppet:///modules/demo/set_txt_record'
  }

  file { '/home/vagrant/named':
    ensure => 'link',
    target => '/var/named/chroot/var/named'
  }

  file { ['/var/named', '/var/named/chroot', '/var/named/chroot/var', '/var/named/chroot/var/named']:
    mode   => '0755',
    ensure => 'directory'
  }
}