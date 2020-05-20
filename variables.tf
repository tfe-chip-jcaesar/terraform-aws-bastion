variable "ami" {
  default = "ami-06fcc1f0bc2c8943f"
}
variable "common_tags" {}
variable "name" {}
variable "size" {
  default = "t2.small"
}
variable "subnet_id" {}
variable "ssh_key" {}
variable "vpc_id" {}
