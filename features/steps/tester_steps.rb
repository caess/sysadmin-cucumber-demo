When(/^I create the Cucumber directories on the "(.*?)" VM under "(.*?)"$/) do |vm_name, directory|
  vm = $VMS[vm_name]

  vm.ssh do |ssh|
    ssh.exec!("mkdir -p #{directory}/features/steps")
    ssh.exec!("mkdir -p #{directory}/features/support")
    ssh.exec!("touch #{directory}/features/support/env.rb")
  end
end

When(/^I upload "(.*?)" to "(.*?)" on the "(.*?)" VM$/) do |filename, destination, vm_name|
  vm = $VMS[vm_name]

  in_current_dir do
    vm.sftp do |sftp|
      sftp.upload!("./#{filename}", destination)
    end
  end
end

When(/^I run the command "(.*?)" on the "(.*?)" VM in the directory "(.*?)"$/) do |command, vm_name, directory|
  vm = $VMS[vm_name]

  vm.ssh do |ssh|
    @output = ssh.exec!("cd #{directory} && #{command}")
  end
end

Then(/^I should see this in the output:$/) do |desired_output|
  @output.should include(desired_output)
end