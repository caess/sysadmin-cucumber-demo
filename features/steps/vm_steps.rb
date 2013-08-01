When(/^I run the command "(.*?)" on the "(.*?)" VM$/) do |command, vm_name|
  vm = $VMS[vm_name]

  vm.ssh do |ssh|
    @output = ssh.exec!(command)
  end
end