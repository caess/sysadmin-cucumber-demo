Given(/^the DNS server "(.*?)"$/) do |server|
  @nameserver = server
end

Given(/^these DNS servers:$/) do |servers|
  @nameservers = servers.raw.map {|row| row[0]}
end

When(/^I query my DNS server for the A record for "(.*?)"$/) do |host|
  resolver = Net::DNS::Resolver.new(:nameservers => @nameserver, :udp_timeout => 15)
  @records = resolver.query(host, Net::DNS::A)
end

When(/^I query my DNS servers for the A record for "(.*?)"$/) do |host|
  records = {}
  @nameservers.each do |server|
    resolver = Net::DNS::Resolver.new(:nameservers => server, :recursive => false, :udp_timeout => 15)
    records[server] = resolver.query(host, Net::DNS::A)
  end

  @nameservers.each do |server|
    next if @nameservers.first == server

    records[@nameservers.first].answer.map {|r| r.to_s}.sort.should \
      eq(records[server].answer.map {|r| r.to_s}.sort),
      "DNS responses from #{@nameservers.first} and #{server} don't match!"
  end

  @records = records[@nameservers.first]
end

Then(/^I should see that the A record response is "(.*?)"$/) do |ip|
  @records.answer.length.should == 1

  @records.answer.first.address.should == ip
end