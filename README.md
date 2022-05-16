Credentials::
============
Root Pwd:  "dineshmarch2o2Z.456"


Pre-script at GCP:
=================

key: "startup-script-url"

Value: "gs://pre-script-k8s/Pre-script_CentOS[1].sh"  ## this value is custom for each project, so dont use this same value on your
                                                      ## project, need to create own by existing same prescript




Pre-script GitHub Link:
========================

https://raw.githubusercontent.com/dineshrhel/k8s/main/gcp_startup-script.sh


Git Repo for Kubernetes Cluster setup:

https://github.com/dineshrhel/kubernetes-and-ansible.git

Example:

#git clone https://github.com/dineshrhel/kubernetes-and-ansible.git /opt 


### To make executable permission on core.sh shell script ####

Ex:

#chmod +x /opt/centos/core.sh


#### To execute below script with example ####

#sh /opt/centos/core.sh <worker1_eth0-IP> <worker2_eth0-IP>  <worker3_eth0-IP> 

Example:

[root@manager centos]# sh core.sh
Please enter Worker Host names separated by space: 10.128.15.211 10.128.15.212 10.128.15.213
Please type ROOT password on SSH prompt::

SSH password:  << Provide ROOT account Password >>


####This script will take almost 2 mins for completing Kubernets cluster setup.


Once script will be done, we can see our Kubernetes cluster info by below command from master node


#kubectl get nodes





Note: If any worker nodes is NOT ready state,It will take/sync up 4 to 5 mins(Max) with master node








