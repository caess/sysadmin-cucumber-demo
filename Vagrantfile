# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provision :puppet, :options => '--verbose' do |puppet|
    puppet.module_path = ["puppet-repo/modules"]
    puppet.manifests_path = "puppet-repo/manifests"
    puppet.manifest_file = "site.pp"
  end

  config.vm.define :tester do |tester|
    tester.vm.box = 'ithiriel-CentOS-6.4-i386-20130714'
    tester.vm.hostname = "tester.example.com"
    tester.vm.network :private_network, ip: "172.22.0.200"
  end

  config.vm.define :dns_master do |dns_master|
    dns_master.vm.box = 'ithiriel-CentOS-6.4-i386-20130714'
    dns_master.vm.hostname = "dns-master.example.com"
    dns_master.vm.network :private_network, ip: "172.22.0.23"
  end
end
