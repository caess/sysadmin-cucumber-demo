Feature: DNS on the slave servers
  As a DNS administrator
  I want the DNS slave servers to provide DNS for the example.com zone
  So I can serve the zone to my customers without exposing the master server

  Scenario: example.com
    Given these DNS servers:
      |172.22.0.24|
      |172.22.0.25|
    When I query my DNS servers for the A record for "example.com"
    Then I should see that the A record response is "192.168.205.199"

  Scenario: Zone file propagation to the slave servers
    Given these DNS servers:
      |172.22.0.23|
      |172.22.0.24|
      |172.22.0.25|
    When I make a change to the "example.com" zone file on the DNS master
    Then I should see that DNS change on all DNS servers