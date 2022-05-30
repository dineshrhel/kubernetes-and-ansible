Credentials::
============
Root Pwd:  "K8s_Cluster2o2z"


Pre-script at GCP:
=================

key: "startup-script-url"

Value: "gs://caxbucket/Pre-script_CentOS.sh"  ## this value is custom for each project, so dont use this same value on your
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

#### Validate Kubernetes Cluster setup is properly configured #####

1. Run below command by ROOT account, all pods should be RUNNING state

Ex:

#kubectl get pods -n kube-system

NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-56cdb7c587-5r5rl   1/1     Running   0          15m
calico-node-tc7jg                          1/1     Running   0          15m
calico-node-vmb4q                          1/1     Running   0          15m
calico-node-xfpwk                          1/1     Running   0          15m
calico-node-xj2cg                          1/1     Running   0          15m
coredns-6d4b75cb6d-4mmmc                   1/1     Running   0          15m
coredns-6d4b75cb6d-knxhx                   1/1     Running   0          15m
etcd-master                                1/1     Running   0          16m
kube-apiserver-master                      1/1     Running   0          16m
kube-controller-manager-master             1/1     Running   0          16m
kube-proxy-78zgt                           1/1     Running   0          15m
kube-proxy-8kbkq                           1/1     Running   0          15m
kube-proxy-p56mq                           1/1     Running   0          15m
kube-proxy-vdrvx                           1/1     Running   0          15m
kube-scheduler-master                      1/1     Running   0          16m


2. To Run Sample Pods (Should be RUNNING state)

for i in {1..5}
do
          kubectl run pod$i --image=nginx
done

Output:
=======

[root@master ~]# kubectl get pods
NAME   READY   STATUS    RESTARTS   AGE
pod1   1/1     Running   0          52s
pod2   1/1     Running   0          52s
pod3   1/1     Running   0          52s
pod4   1/1     Running   0          52s
pod5   1/1     Running   0          52s



#### Validation done successfully !!! ###########











