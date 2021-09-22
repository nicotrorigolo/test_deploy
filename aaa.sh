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
sed -i 's/127.0.0.1:6443/10.12.0.10:6443/g' /home/vagrant/.kube/config

echo "Recuperation des donnees à ajouter au depot du tp fil rouge"
git clone https://github.com/nicotrorigolo/test_deploy

echo "Installation de helm"
sudo snap install helm --classic
sudo wget https://github.com/roboll/helmfile/releases/download/v0.139.9/helmfile_linux_amd64 -O /usr/local/bin/helmfile
sudo chmod +x /usr/local/bin/helmfile
helm plugin install https://github.com/databus23/helm-diff

echo "Mise en place du cluster"
cd /home/vagrant/test_deploy/k8s/
helmfile apply
# cd /home/vagrant/test_deploy/k8s/cert-manager
# kubectl apply -n cert-manager -f .