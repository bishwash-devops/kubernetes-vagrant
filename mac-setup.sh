#!/bin/bash
set -ex

CWD=$(dirname $0)
CERT=$CWD/kubemaster/root/kubecfg.p12
PASSWORD=password
KUBE_CONFIG=$CWD/kubemaster/etc/kubernetes/admin.conf
TOKEN=$CWD/kubemaster/root/admin_user.txt
KUBE_MASTER_IP=192.168.56.10

sudo security import $CERT -k /Library/Keychains/System.keychain -P $PASSWORD

cp $KUBE_CONFIG ~/.kube/config

echo "Kube Dashboard Login Token: " 
cat $TOKEN

echo "Kube Dashboard URL: https://${KUBE_MASTER_IP}:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy"
