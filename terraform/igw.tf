resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.GenericVPC.id

   tags = {
       Name = "Internet Gateway"
    } 
  
}
