variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "user_file" {
  type = string
}

variable "security_group_id" {
  
  type = string
}