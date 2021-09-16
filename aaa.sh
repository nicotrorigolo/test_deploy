#!/bin/bash

echo "Installation de docker"
sudo apt update
sudo apt install -y docker.io
sudo usermod -aG docker vagrant

echo "Installation de kubernetes"
sudo snap install kubectl --classic

echo "Installation de k3s"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh - 
mkdir .kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/
sudo mv /home/vagrant/.kube/k3s.yaml /home/vagrant/.kube/config
sudo chown vagrant /home/vagrant/.kube/config
sed -i 's/127.0.0.1:6443/192.168.10.10:6443/g' /home/vagrant/.kube/config