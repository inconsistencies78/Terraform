provider "aws" {
  region = "eu-central-1"
}


# strings
variable "vpcname" {
  type = string
  default = "myvpc"
}


# integer
variable "sshport" {
  type = number  # muss nicht in ""
  default = 22
}


# booleans
variable "enabled" {
  default = true
}


# list. ein array.
variable "mylist" {
  type = list(string)  # könnte in der Klammer auch ein integer oder ein booleans sein
  default = ["Value1","Value2"]
}


# maps
variable "mymap" {
  type = map
  default = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}


# input. um Eingaben zu machen
variable "inputname" {
  type = string  # wir könnten auch map oder list oder anderes nehmen
  description = "Set the Name of the VPC"  # die Beschreibung des Inputs, die später angezeigt wird und eine Eingabe zb einfordert
}


resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname
# andere Variante
    # Name = var.mylist[1] um den Wert "Value2" aaus der Liste mylist zu nehmen
    # Name = var.mymap["Key2"] um den Wert "Value2" aus der Map mymap zu nehmen
    # Name = var.vpcname  # aus String Variable aus Zeile 7
  }
}

# als nächstes Terminal und $"terraform init" und dann "terraform plan"


output "myoutput" {
  value = aws_vpc.myvpc.id  # das ist ein Attribut. die ID wird durch AWS erstellt, also erst, wenn wir terraform apply laufen lassen
# value = type.name.attribut
}


# tuple. Abschnitt 37
variable "mytuple" {
  type = tuple([string, number, string])
  default = ["cat", 1, "dog"]
}


# objects. Abschnitt 37
variable "myobjects" {
  type = objects({name = string, port = list(number)})
  default = {
    name = "AnBa"
    port = [22, 25, 80]
  }
}