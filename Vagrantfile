# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "http://cloud-images.ubuntu.com/vagrant/trusty/20140712/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network "private_network", type: "dhcp"

  config.vm.network "forwarded_port", guest: 5000, host: 5000, auto_correct: true

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "ext/vagrant"
  end
end
