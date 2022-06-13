printf "\n[ADDING CLUSTER TO CONTEXT]\n"
aws eks update-kubeconfig --name my-eks-cluster
printf "\n[PRINTING EKS NODES]\n"
kubectl get node
printf "\n[CREATING NAMESPACE 'eks-sample-app']\n"
kubectl create namespace eks-sample-app
printf "\n[APPLY DEPLOYMENT MANIFEST TO CLUSTER]\n"
kubectl apply -f eks-sample-deployment.yaml
printf "\n[APPLY SERVICE MANIFEST TO CLUSTER]\n"
kubectl apply -f eks-sample-service.yaml
printf "\n[OPENING EKS EXPOSED DEPLOYMENT IN BROWSER]\n"
load_balancer=$(kubectl get service --all-namespaces | grep eks | awk -v N=5 '{print $5}')
printf "load balancer:  $load_balancer\n\n"
firefox $load_balancer
