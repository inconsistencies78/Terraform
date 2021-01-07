provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "myvpc" {  # wir erstellen ein vpc mit dem Namen "myvpc"
  cidr_block = "10.0.0.0/16"
}

# Infos zu CIDR: https://www.ionos.de/digitalguide/server/knowhow/classless-inter-domain-routing/

