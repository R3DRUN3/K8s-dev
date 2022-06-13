# Getting started with kubernetes on prem

## Abstract
Provision an on-prem Kubernetes test cluster with vagrant and ansible.

## Prerequisites
`vagrant` `ansible` `virtualbox`

## Instructions

For this tutorial we will make use of [this](https://github.com/itwonderlab/ansible-vbox-vagrant-kubernetes) fantastic repo.

Clone the repo:
```console
git clone https://github.com/itwonderlab/ansible-vbox-vagrant-kubernetes.git && cd ansible-vbox-vagrant-kubernetes
```

start vagrant provisioning:

```console
vagrant up
```

Once finished, create ssh tunnel with the Kubernetes master node:

```console
ssh -L localhost:8001:127.0.0.1:8001 vagrant@192.168.50.11
``` 

Connect to the master node via vagrant ssh utility:  
  
```console
vagrant ssh k8s-m-1
```

Now we will manually deploy Kubernetes dashboard.
<br>
deploy it with the following command:  

```console
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.0/aio/deploy/recommended.yaml
```
Create full privilege admin user:
```console
mkdir ~/dashboard && cd ~/dashboard
```

create a yml file:  
```console
nano dashboard-admin.yaml
```
and paste the following content:
```yml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
```
Deploy the admin user role:
```console
kubectl apply -f dashboard-admin.yaml
```
Create admin login token
```console
kubectl -n kubernetes-dashboard create token admin-user
```
start proxy:
```console
kubectl proxy
```
Move to the local host, open the browser to the dashboard UI and login with the generated token:
```console
firefox http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```
Create our app deployment:
click on the '+' sing on the top right and select create => form

add the following data:

![alt text](https://github.com/R3DRUN3/K8s-dev/blob/main/K8s-on-prem/images/k8s-dashboard-deployment.png)

check progress in workload:
![alt_text](https://github.com/R3DRUN3/K8s-dev/blob/main/K8s-on-prem/images/k8s-dashboard-workload.png)


check the deployed app on the worker nodes:

![alt_text](https://github.com/R3DRUN3/K8s-dev/blob/main/K8s-on-prem/images/container-app.png)



