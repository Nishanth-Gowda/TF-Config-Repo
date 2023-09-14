# create VPC
module "VPC" {
  source           = "../modules/VPC"
  REGION           = var.REGION
  PROJECT_NAME     = var.PROJECT_NAME
  VPC_CIDR         = var.VPC_CIDR
  PUB_SUBNET_1_CIDR    = var.PUB_SUBNET_1_CIDR
  PUB_SUBNET_2_CIDR    = var.PUB_SUBNET_2_CIDR
  PRI_SUBNET_3_CIDR    = var.PRI_SUBNET_3_CIDR
  PRI_SUBNET_4_CIDR    = var.PRI_SUBNET_4_CIDR
}

# create NAT GATEWAY
module "Nat-GW" {
  source           = "../modules/NAT"
  IGW_ID           = module.VPC.IGW_ID
  VPC_ID           = module.VPC.VPC_ID
  PUB_SUBNET_1_ID      = module.VPC.PUB_SUBNET_1_ID
  PUB_SUBNET_2_ID      = module.VPC.PUB_SUBNET_2_ID
  PRI_SUBNET_3_ID      = module.VPC.PRI_SUBNET_3_ID
  PRI_SUBNET_4_ID      = module.VPC.PRI_SUBNET_4_ID
}

# create IAM
module "IAM" {
  source           = "../modules/IAM"
  PROJECT_NAME     = var.PROJECT_NAME
}

# create EKS Cluster
module "EKS" {
  source               = "../modules/EKS"
  PROJECT_NAME         = var.PROJECT_NAME
  EKS_CLUSTER_ROLE_ARN = module.IAM.EKS_CLUSTER_ROLE_ARN
  PUB_SUBNET_1_ID        = module.VPC.PUB_SUBNET_1_ID
  PUB_SUBNET_2_ID        = module.VPC.PUB_SUBNET_2_ID
  PRI_SUBNET_3_ID        = module.VPC.PRI_SUBNET_3_ID
  PRI_SUBNET_4_ID        = module.VPC.PRI_SUBNET_4_ID
}

# create Node Group
module "NodeGroup" {
  source               = "../modules/NodeGroup"
  NODE_GROUP_ARN  = module.IAM.NODE_GROUP_ROLE_ARN
  PRI_SUBNET_3_ID          = module.VPC.PRI_SUBNET_3_ID
  PRI_SUBNET_4_ID          = module.VPC.PRI_SUBNET_4_ID
  EKS_CLUSTER_NAME     = module.EKS.EKS_CLUSTER_NAME
}
