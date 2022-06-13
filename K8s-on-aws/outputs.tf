#Terraform will return the cluster id and the cluster public endpoint once provisioning is complete
output "cluster_id" {
    value = module.eks.cluster_id
}
output "cluster_public_endpoint" {
    value = module.eks.cluster_endpoint
}