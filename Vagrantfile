# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"
HOST_ONLY_NETWORK="vboxnet0"

# HOST_ONLY_NETWORK_IP=192.168.56.1

# master_cpu = 2
# master_memory = 2048

# workers = 2
# worker_cpu = 2
# worker_memory = 2048


cluster = {
  "kubemaster" => { :ip => "192.168.56.10", :cpus => 2, :mem => 2048 },
  "kubeworker1" => { :ip => "192.168.56.11", :cpus => 2, :mem => 2048 }
}
 

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.boot_timeout = 600
  cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |cfg|
        cfg.vm.box = "bento/ubuntu-16.04"
        cfg.vm.hostname = hostname
        cfg.vm.provider "virtualbox" do |vb, override|        
          cfg.vm.network "private_network", ip: "#{info[:ip]}", :name => HOST_ONLY_NETWORK, :adapter => 2
          vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
        end # end provider


      # provision nodes with ansible
      if index == cluster.size - 1
        cfg.vm.provision :ansible do |ansible|
          # Disable default limit to connect to all the machines
          ansible.limit = "all"
          ansible.groups = {
            "master" => ["kubemaster"],
            "worker" => ["kubeworker1"],
            "all:vars" => {
              "user" => "vagrant"
            }
          }
          ansible.playbook = "ansible-playbook.yml"
          #ansible.tags = "deploy"

        end # end ansible
      end # end if 


    end # end cfg
  end # end hostname
end # end config
