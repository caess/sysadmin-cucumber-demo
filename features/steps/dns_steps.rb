require 'pp'

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

    records[@nameservers.first].answer.map {|r| r.address}.sort.should \
      eq(records[server].answer.map {|r| r.address}.sort),
      "DNS responses from #{@nameservers.first} and #{server} don't match!"
  end

  @records = records[@nameservers.first]
end

Then(/^I should see that the A record response is "(.*?)"$/) do |ip|
  @records.answer.length.should == 1

  @records.answer.first.address.should == ip
end

When(/^I make a change to the "(.*?)" zone file on the DNS master$/) do |zone|
  @zone = zone
  @wanted_txt_record = Base64.encode64(Time.now.to_s).strip

  vm = $VMS['dns_master']

  vm.ssh do |ssh|
    output = ssh.exec!("./set_txt_record #{@zone} #{@wanted_txt_record}")
    output.should be_nil, "Unable to set TXT record on DNS master."

    output = ssh.exec!("sudo rndc reload")
    output.strip.should eq("server reload successful"), "rndc failed on DNS master."
  end
end

Then(/^I should see that DNS change on all DNS servers$/) do
  nameservers = [
    '172.22.0.23',
    '172.22.0.24',
    '172.22.0.25'
  ]

  records = {}
  nameservers.each do |server|
    resolver = Net::DNS::Resolver.new(:nameservers => server, :recursive => false, :udp_timeout => 15)
    records[server] = resolver.query(@zone, Net::DNS::TXT)
  end

  nameservers.each do |server|
    next if nameservers.first == server

    records[nameservers.first].answer.map {|r| r.txt}.sort.should \
      eq(records[server].answer.map {|r| r.txt}.sort),
      "DNS responses from #{nameservers.first} and #{server} don't match!"
  end

  records[nameservers.first].answer.length.should eq(1), "More than one TXT record found."

  real_txt_record = records[nameservers.first].answer.first.txt.strip
  real_txt_record.should eq(@wanted_txt_record), "TXT record doesn't match expected!\nWanted: #{@wanted_txt_record}\nGot: #{real_txt_record}"
end