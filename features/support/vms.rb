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
  'tester' => VagrantVM.new('172.22.0.200')
}