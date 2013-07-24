Given(/^the DNS server "(.*?)"$/) do |server|
  @nameserver = server
end

When(/^I query my DNS server for the A record for "(.*?)"$/) do |host|
  resolver = Net::DNS::Resolver.new(:nameservers => @nameserver, :udp_timeout => 15)
  @records = resolver.query(host, Net::DNS::A)
end

Then(/^I should see that the A record response is "(.*?)"$/) do |ip|
  @records.answer.length.should == 1

  @records.answer.first.address.should == ip
end