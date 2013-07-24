Feature: Cucumber on the tester VM
  As the author of a blog post
  I want Cucumber to run correctly on the tester VM
  So that readers may run Cucumber when they use the demo environment

  Scenario: Cucumber
    Given a file named "test.feature" with:
      """
      Feature: Test feature
        Scenario: Test
          * I should see that true is true
      """
    And a file named "test_steps.rb" with:
      """
      Then /^I should see that true is true$/ do
        true.should == true
      end
      """
    When I create the Cucumber directories on the "tester" VM under "/home/vagrant/tmp"
    And I upload "test.feature" to "/home/vagrant/tmp/features/test.feature" on the "tester" VM
    And I upload "test_steps.rb" to "/home/vagrant/tmp/features/steps/test_steps.rb" on the "tester" VM
    And I run the command "cucumber" on the "tester" VM in the directory "/home/vagrant/tmp"
    Then I should see this in the output:
      """
      1 scenario (1 passed)
      1 step (1 passed)
      """

  Scenario: Net::DNS
    Given a file named "test.feature" with:
      """
      Feature: Test feature
        Scenario: Test
          When I query for the A record for "google-public-dns-a.google.com"
          Then I should see that the A record response is "8.8.8.8"
      """
    And a file named "test_steps.rb" with:
      """
      require "net/dns"

      When /^I query for the A record for "(.*?)"$/ do |host|
        resolver = Net::DNS::Resolver.new(:udp_timeout => 15)
        @records = resolver.query(host, Net::DNS::A)
      end

      Then /I should see that the A record response is "(.*?)"$/ do |ip|
        @records.answer.length.should == 1

        @records.answer.first.address.should == ip
      end
      """
    When I create the Cucumber directories on the "tester" VM under "/home/vagrant/tmp"
    And I upload "test.feature" to "/home/vagrant/tmp/features/test.feature" on the "tester" VM
    And I upload "test_steps.rb" to "/home/vagrant/tmp/features/steps/test_steps.rb" on the "tester" VM
    And I run the command "cucumber" on the "tester" VM in the directory "/home/vagrant/tmp"
    Then I should see this in the output:
      """
      1 scenario (1 passed)
      2 steps (2 passed)
      """
