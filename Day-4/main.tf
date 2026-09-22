resource "aws_vpc" "abhi" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "abhi-vpc"
  }
}

resource "aws_subnet" "abhi" {
    vpc_id     = aws_vpc.abhi.id
    cidr_block = var.subnet_cidr
    tags = {
        Name = "abhi-subnet1"
    }
}

resource "aws_internet_gateway" "abhi" {
    vpc_id = aws_vpc.abhi.id
}

resource "aws_route_table" "abhi" {
    vpc_id = aws_vpc.abhi.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.abhi.id
    }
} 

resource "aws_route_table_association" "abhi" {
    subnet_id      = aws_subnet.abhi.id
    route_table_id = aws_route_table.abhi.id
}

resource "aws_security_group" "abhi" {
    name        = "abhi-sg"
    description = "Security group for abhi"
    vpc_id      = aws_vpc.abhi.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "abhi" {
  ami                    = "ami-0fef201115eefe936"
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.abhi.id
  vpc_security_group_ids = [aws_security_group.abhi.id]

  tags = {
    Name = "abhi-instance"
  }
}


