#!/bin/bash

####Ansible playbook location######
#script_location=/etc/ansible/kubernetes-and-ansible/centos
script_location=$(find / -type d -name "centos" | grep -v boot)
cp -p /etc/hosts /etc/hosts-`date "+%d-%b-%y--%H:%M"`

rm -f /tmp/host_names.txt
rm -f /tmp/dummy_host_entries1

##### To provide worker nodes host entries #####
read -r -p "Please enter Worker Host names separated by space: " -a arr
for host_name in "${arr[@]}"; do 
   echo -e "$host_name" >> /tmp/host_names.txt
done

##### To update system host entries #####

cat /tmp/host_names.txt | while read output
do

worker_ips1=$(nslookup $output| head -n 1 | cut -d "=" -f 2 | column -t)
worker_ips2=${worker_ips1::-1}
worker_ips3=$(echo $worker_ips2 | cut -d "." -f 1)

echo -e $output $worker_ips2 $worker_ips3 >> /etc/hosts

done

cat /etc/hosts > /tmp/dummy_host_entries1

cat /tmp/dummy_host_entries1 | sort | uniq > /etc/hosts

cat /etc/hosts |grep -iv "metadata.google.internal" > /tmp/dummy_host_entries2

#### To install Ansible package on Master node#####

yum install ansible -y  > /dev/null 



#### To update ansible host entry file ######

echo -e "[kubernetes-master-nodes]" > /tmp/dummy
echo -e "`hostname -s` ansible_connection=local" >> /tmp/dummy
echo -e "" >> /tmp/dummy
echo -e "[kubernetes-worker-nodes]" >> /tmp/dummy

cat /tmp/host_names.txt | while read output
do 
sed -i '/\[kubernetes-worker-nodes\]/a '"$output"'' /tmp/dummy
done
cat /tmp/dummy | uniq > /etc/ansible/hosts

sed -i 's/#host_key_checking = False/host_key_checking = False/g' /etc/ansible/ansible.cfg
sed -i 's/#deprecation_warnings = True/deprecation_warnings = False/g' /etc/ansible/ansible.cfg

yes | cp -f /etc/ansible/ansible.cfg $script_location/ansible.cfg
yes | cp -f /etc/ansible/hosts $script_location/hosts


### To retrive k8s source code from Git ###

#git clone https://github.com/dineshrhel/kubernetes-and-ansible.git /etc/ansible/kubernetes-and-ansible

#### To update master node IP on script's env file #####
export master_host_name=$(hostname -s)
env_ip1=$(cat $script_location/playbooks/env_variables | grep -i ad_addr | awk '{print $2}')
master_node_ip=$(ifconfig | grep -A4 "eth0" |grep -w "inet" | awk '{print $2}')
sed -i 's/'$env_ip1'/'$master_node_ip'/g' $script_location/playbooks/env_variables


rm -f /tmp/host_names.txt
rm -f /tmp/dummy

#################To Execute ansible playbook for SSH passwordless and system host entry updates ####

echo -e "Please type ROOT password on SSH prompt:: "
echo ""

sleep 5

ansible-playbook $script_location/passwordless_host-updates.yml -k

################# To setup Kubernetes Cluster with all prerequistes ####
echo -e "To setup Kubernetes Cluster with all prerequistes, It takes some times, Please wait.."

sleep 5
ansible-playbook $script_location/settingup_kubernetes_cluster.yml

################ To join workers nodes into Master Kubernetes Cluster ######

sleep 2

echo -e "To join all specified workers nodes into Master Kubernetes Cluster..."

ansible-playbook $script_location/join_kubernetes_workers_nodes.yml

printf '\n%.0s' `seq 1 5`
sleep 30

echo -e "Your Kubernetes Cluster setup ready!!!"
echo ""

