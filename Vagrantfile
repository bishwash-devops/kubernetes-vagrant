# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"

cluster = {
  "kubemaster" => { :ip => "192.168.56.10", :cpus => 1, :mem => 1024 },
  # "kubenode01.bis.com" => { :ip => "192.168.56.11", :cpus => 1, :mem => 1024 }
}
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.boot_timeout = 600
  cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |cfg|
        cfg.vm.box = "bento/ubuntu-16.04"
        cfg.vm.hostname = hostname
        cfg.vm.provider "virtualbox" do |vb, override|        
          cfg.vm.network "private_network", ip: "#{info[:ip]}", :name => 'vboxnet0', :adapter => 2
          vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
        end # end provider

        if hostname == "kubemaster"
			cfg.vm.provision :ansible do |ansible|
				# Disable default limit to connect to all the machines
				ansible.limit = "all"
				ansible.playbook = "master-playbook.yml"
        	end # end ansible
        end # if
    end # end cfg
  end # end hostname
end # end config
