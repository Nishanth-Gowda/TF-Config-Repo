output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUB_SUBNET_1_ID" {
  value = aws_subnet.pub_subnet_1.id
}
output "PUB_SUBNET_2_ID" {
  value = aws_subnet.pub_subnet_2.id
}
output "PRI_SUBNET_3_ID" {
  value = aws_subnet.pri_subnet_3.id
}

output "PRI_SUBNET_4_ID" {
  value = aws_subnet.pri_subnet_4.id
}
output "IGW_ID" {
    value = aws_internet_gateway.igw
}

output "REGION" {
  value = var.REGION
}