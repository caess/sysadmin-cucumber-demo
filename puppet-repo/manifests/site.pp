node "tester.example.com" {
  # RPMs
  package { 'gcc':
    ensure => installed
  }

  package { 'make':
    ensure => installed
  }

  # Gems
  package { 'rspec':
    ensure => installed,
    provider => 'gem'
  }

  package { 'cucumber':
    ensure => installed,
    provider => 'gem',
    require => [Package['make'], Package['gcc'],Package['rspec']]
  }

  package { 'net-dns':
    ensure => installed,
    provider => 'gem'
  }
}