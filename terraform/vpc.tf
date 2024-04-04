# Create initial VPC stack and structure
resource "aws_vpc" "GenericVPC" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_hostnames = var.dnsHostNames
  enable_dns_support   = var.dnsSupport
  
  tags = {
    Name = "Main VPC"
  }

 
  
}

# Create a public subnet for the VPC EC2 instance receive traffic


# Create standard generic security group
resource "aws_security_group" "GenericSG0" {
    name = "Generic Security Group"

    ingress {
        from_port = 80
        to_port   = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 

    ingress {
       from_port = 443 
       to_port = 443
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"] 
    }  
}

# Create Public network ACL - Access Control List
resource "aws_network_acl" "PublicGeneralNACL" {
    vpc_id     = aws_vpc.GenericVPC.id
    subnet_ids = [ aws_subnet.GeneralSubnet.id ]

      ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block = var.publicdestCIDRblock
        from_port   = 22
        to_port     = 22
        
    } 

    egress {
       protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block = var.publicdestCIDRblock
        from_port   = 22
        to_port     = 22
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block = var.publicdestCIDRblock
        from_port   = 80
        to_port     = 80
        
    } 

    egress {
       protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block = var.publicdestCIDRblock
        from_port   = 80
        to_port     = 80
    }

     tags = {
       Name = "Public NACL"
    }
  

  
}


# Create routing table
resource "aws_route_table" "GeneralRouteTable" {
    vpc_id = aws_vpc.GenericVPC.id

    tags = {
        Name = "Public Route Table"
    }
  
}

# Create routing rule
resource "aws_route" "InternetAccess" {
    route_table_id         = aws_route_table.GeneralRouteTable.id
    destination_cidr_block = var.publicdestCIDRblock
    gateway_id             = aws_internet_gateway.GeneralGateway.id
  
}

# Create route table association
resource "aws_route_table_association" "GeneralPublicAssociation" {
    subnet_id      = aws_subnet.GeneralSubnet.id
    route_table_id = aws_route_table.GeneralRouteTable.id
  
}