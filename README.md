
Root Pwd:  "dineshmarch2o2Z.456"

#### To execute below script with example ####

#sh core.sh <worker1_eth0-IP> <worker2_eth0-IP>  <worker3_eth0-IP> 

Example:

[root@manager centos]# sh core.sh
Please enter Worker Host names separated by space: 10.128.15.211 10.128.15.212 10.128.15.213
Please type ROOT password on SSH prompt::

SSH password:  << Provide ROOT account Password >>


####This script will take almost 2 mins for completing Kubernets cluster setup.


Once script will be done, we can see our Kubernetes cluster info by below command from master node


#kubectl get nodes





Note: If any worker nodes is NOT ready state,It will take/sync up 4 to 5 mins(Max) with master node








