# Kubernets Cluster using Vagrant
Vagrant 2.1.5
VirtualBox 5.2.18

## Network Configuration
### Container to Container:
A Pod consists of one ore more containers that are configured to share a network stack and other resources (volumes, cpu, ram, etc.). 

**Pause Container:**  is a container which holds the network namespace for the pod. It serves as the basis of Linux namespace sharing and with process ID namespace sharing enabled, it serves as PID 1 for each pod and reaps zombie processes.

### Pod to Pod:
One pod should be able to communicate with another pod using the IP of the second pod. The IP that a container sees itself as is the same IP that others see it as. The goal is for each pod to have an IP in a flat shared networking namespace that has full communication with other physical computers and containers across the network. Where POD can be treated much like VMs or Physical hosts from networking perspective.

**Select an address range for the Pod IPs:**
- 10.10.0.0/24 range for the cluster which allows 256 Total
- Use 10.10.0.0/24 for each node allowing 256

**In Virtual Box - Create Host-Only Network:** VirtualBox -> Preference -> Network -> Host-Only Networks -> +, to Create.

It adds an extra network device to your computer and can be treated just as if it were another ethernet card.

Get the Ip Address for vboxnet0, which is 192.168.56.1/24, in my case.

We will select, 
- Static IP for master Node: MASTER_IP=192.168.56.10
- Short and Unique Name for the Cluster: CLUSTER_NAME=DEV_CLUSTER

- Static IP for worker Node1: 192.168.56.11
- Static IP for worker Node2: 192.168.56.22

We will use [Calico](https://docs.projectcalico.org/v3.2/introduction/), for secure network connectivity for containers and virtual machine workloads.


**Pod to Service:** A service is a kubernetes resource that is configured to forward requests to a set of pods. Kubernetes also allocates an IP to each service. However, service IPs do not necessarily need to be routable. The kube-proxy takes care of translating Service IPs to Pod IPs before traffic leaves the node. You do need to allocate a block of IPs for services.

Service Types:
- Cluster Ip: Exposes the service on a cluster-internal IP. Makes the service reachable only within the cluster. This is the default service type.
- Node Port: Exposes the service on each Node's IP at a static port. A Cluster IP service to which Node Port service will route is automatically created.
- Load Balancer: Exposes the service externally using a cloud provider's load balancer. Services to which the external load balancer will route, are automatically created. 
- Externam Name: Maps the service to the contents of the external name field by returning a CNAME record with its value. No proxying of any kind is setup.


Problems to Solve
- Container-to-Container Communication
- Pod-to-Pod Communications
- Pod-to-Service Communication
- External-to-Service Communication

Fundamental requirements:
1. All Containers can communicated with all other containers without NAT
2. ALl Nodes can communicate with all contailers (and vice-versa) without NAT
3. The IP that a container sees itself as is the same IP that others see it as
















# References
Reference for Networking Model Design Proposals: https://github.com/kubernetes/community/blob/master/contributors/design-proposals/network/networking.md 

Vagrant Deployer for Kubernetes Ansible : https://github.com/kubernetes/contrib/tree/master/ansible/vagrant


## Appendix
####Terminal Color Preference:
```
export PS1="\e[0;32m\$ \e[m ";
export CLICOLOR=1;
```

####Sync VirtualBox Guest Additions
$ vagrant plugin install vagrant-vbguest 

