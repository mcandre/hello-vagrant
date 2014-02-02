VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  # Install puppet modules
  config.vm.provision :shell do |shell|
    shell.inline = 'mkdir -p /etc/puppet/modules; puppet module install --force puppetlabs/ruby'
  end

  config.vm.provision :puppet
end
