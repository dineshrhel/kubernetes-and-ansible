#!/bin/bash
sudo chpasswd <<<"root:dineshmarch2o2Z.456"
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo systemctl stop firewalld
sudo systemctl disable firewalld
yum install wget git bind-utils yum-utils -y
