variable "launch_template_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "tg_arns" {
  type = string
}