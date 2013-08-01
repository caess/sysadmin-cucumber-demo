class VagrantVM
  def initialize(host)
    @host = host
  end

  def ssh
    Net::SSH.start(@host, 'vagrant', :keys => "#{ENV['HOME']}/.vagrant.d/insecure_private_key") do |ssh|
      yield ssh
    end
  end

  def sftp
    Net::SFTP.start(@host, 'vagrant', :keys => "#{ENV['HOME']}/.vagrant.d/insecure_private_key") do |sftp|
      yield sftp
    end
  end
end

$VMS = {
  'dns_master' => VagrantVM.new('172.22.0.23'),
  'dns_slave1' => VagrantVM.new('172.22.0.24'),
  'dns_slave2' => VagrantVM.new('172.22.0.25'),
  'tester' => VagrantVM.new('172.22.0.200')
}