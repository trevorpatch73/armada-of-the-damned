# Variables Inherited From Terraform Cloud
variable AWS_ACCESS_KEY_ID {
    type = string 
}

variable AWS_SECRET_ACCESS_KEY {
    type = string 
}

# Variables Edited & Pushed By The Armada Captain
variable armada_captain_ipaddressv4 {
    type = string
    default = 0.0.0.0/0
}

variable swine_count {
    type = string
    default = 2
}