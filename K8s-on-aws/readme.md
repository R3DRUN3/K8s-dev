# Getting started with Kubernetes on AWS

<p><img width="180" height="180" src="https://github.com/yurijserrano/Github-Profile-Readme-Logos/blob/master/cloud/amazon.svg"></p>






## Abstract
Amazon Elastic Kubernetes Service (*Amazon EKS*) is a managed service that you can use to run Kubernetes on AWS without needing to install, operate, and maintain your own Kubernetes control plane or nodes. 

This repo contains IaC scripts for provisioning an EKS cluster on aws and deploy a flask web app on the cluster.
The EKS cluster will have 2 worker nodes.
<br>
Adjust region and other variables inside configuration file to adapt the procedure to your needs.

## Prerequisites
`terraform` `aws cli` `kubectl`

Tested on `Ubuntu 22.04 LTS`

## Instructions
clone this repo: 
```console
https://github.com/R3DRUN3/K8s-dev.git \
&& cd K8s-dev/K8s-on-aws 
```

Launch EKS provisioning via Terraform with the following command:
```console
sh terraform_deploy.sh
```
Once the procedure is finished (takes about 10 minutes), configure Kubernetes deployment and service with the following command:
```console
eks_service_deploy.sh
```
Output sample:
```console
[ADDING CLUSTER TO CONTEXT]
Updated context arn:aws:eks:eu-central-1:210872676119:cluster/my-eks-cluster in /home/user/.kube/config

[PRINTING EKS NODES]
NAME                                          STATUS   ROLES    AGE     VERSION
ip-10-0-1-13.eu-central-1.compute.internal    Ready    <none>   3m20s   v1.21.12-eks-5308cf7
ip-10-0-2-148.eu-central-1.compute.internal   Ready    <none>   3m26s   v1.21.12-eks-5308cf7
ip-10-0-2-227.eu-central-1.compute.internal   Ready    <none>   3m11s   v1.21.12-eks-5308cf7

[CREATING NAMESPACE 'eks-sample-app']
namespace "eks-sample-app" created

[APPLY DEPLOYMENT MANIFEST TO CLUSTER]
deployment.apps/eks-sample-flask-deployment created

[APPLY SERVICE MANIFEST TO CLUSTER]
service/eks-sample-flask-service created

[OPENING EKS EXPOSED DEPLOYMENT IN BROWSER]
load balancer:  ad8b077a11a774668acd6a56ff4edadc-1210677540.eu-central-1.elb.amazonaws.com
```

Firefox will open automatically (if installed) pointing directly to the LoadBalancer URL of the Kubernetes service and we can confirm that our web-app flask has been correctly exposed:

![alt_text](https://github.com/R3DRUN3/K8s-dev/blob/main/K8s-on-aws/images/web-app.png)

To release all creted resources on aws simply run:
```console
terraform destroy
```
