# Kubernets Cluster using Vagrant
Vagrant 2.1.5
VirtualBox 5.2.18

## Network Configuration
In Kubernetes One pod should be able to communicate with another pod using the IP of the second pod.

Kubernetes also allocates an IP to each service. However, service IPs do not necessarily need to be routable. The kube-proxy takes care of translating Service IPs to Pod IPs before traffic leaves the node. You do need to allocate a block of IPs for services.

**Select an address range for the Pod IPs:**
- 10.10.0.0/24 range for the cluster which allows 256 Total
- Use 10.10.0.0/24 for each node allowing 256

**In Virtual Box:**
VirtualBox -> Preference -> Network -> Host-Only Networks -> +, to Create.

It adds an extra network device to your computer and can be treated just as if it were another ethernet card.

Get the Ip Address for vboxnet0, which is 192.168.56.1/24, in my case.

**Pick Static IP for master Node:** MASTER_IP=192.168.56.10

**Pick Short and Unique Name for the Cluster:** CLUSTER_NAME=DEV_CLUSTER














## Appendix
####Terminal Color Preference:
```
export PS1="\e[0;32m\$ \e[m ";
export CLICOLOR=1;
```

####Sync VirtualBox Guest Additions
$ vagrant plugin install vagrant-vbguest 
