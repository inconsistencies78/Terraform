# udemy kurs Terraform on AWS. Abschnitt 5. EC2
# mehr Infos zu den Instances unter:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# Infos zu t2.micro als Instance unter:
# https://aws.amazon.com/de/ec2/instance-types/
# https://aws.amazon.com/de/ec2/instance-types/t2/
# ami von EC2 unter:
# https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#LaunchInstanceWizard:


provider "aws" {
    region = "eu-central-1"
}

variable "ingressrules" {
  type = list(number)
  default = [80,443]
  
}

variable "egressrules" {
  type = list(number)
  default = [80,443,25,3306,8080]
  
}

resource "aws_instance" "ec2" {
  ami = "ami-03c3a7e4263fd998c"
  instance_type = "t2.micro"
  tags = {
    Name = "1st-EC2"
  }
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
    from_port = port.value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
    from_port = port.value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
}