Feature: DNS on the master server
  As a DNS administrator
  I want the DNS master server to respond to DNS
  So I can serve the example.com zone to my customers

  Scenario: example.com
    Given the DNS server "172.22.0.23"
    When I query my DNS server for the A record for "example.com"
    Then I should see that the A record response is "192.168.205.199"