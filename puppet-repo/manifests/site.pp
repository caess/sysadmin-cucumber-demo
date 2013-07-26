node "tester.example.com" {
  include demo::tester
}

node "dns-master.example.com" {
  include demo::dns_master
}

node "dns-slave1.example.com" {
  include demo::dns_slave
}

node "dns-slave2.example.com" {
  include demo::dns_slave
}