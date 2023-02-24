#terraform {
  #required_providers {
    #vault = {
    #  source = "hashicorp/vault"
   #   version = "2.20.0"
  #  }
 # }
#}

#provider "vault" {
 # address = "http://<YourVAULT_IP>:8200"
#}

provider "aws" {
  region = var.region
  access_key = "AKIARYEK7HVNJ4AA2CDJ"
  secret_key = "m/0M7NUnNELNp5vIpL3oMWCMtdex9nMmnvBJiFz4"

}
