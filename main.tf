# Random Generator for Uneeknuss
resource "random_string" "random" {
  count   = var.swine_count
  length  = 4
  special = false
  upper   = false
}

# Establish the network infrastructure
resource "aws_vpc" "armada_of_the_damned_vpc" {
  cidr_block = "30.0.0.0/24"

  tags = {
    Project = "armada-of-the-damned"
  }
}

resource "aws_subnet" "armada_of_the_damned_subnet" {
  vpc_id                  = aws_vpc.armada_of_the_damned_vpc.id
  cidr_block              = "30.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  depends_on = [
    aws_vpc.armada_of_the_damned_vpc
  ]

  tags = {
    Project = "armada-of-the-damned"
  }
}

resource "aws_internet_gateway" "armada_of_the_damned_igw" {
  vpc_id = aws_vpc.armada_of_the_damned_vpc.id

  depends_on = [
    aws_vpc.armada_of_the_damned_vpc
  ]

  tags = {
    Project = "armada-of-the-damned"
  }
}

resource "aws_route_table" "armada_of_the_damned_rt" {
  vpc_id = aws_vpc.armada_of_the_damned_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.armada_of_the_damned_igw.id
  }

  depends_on = [
    aws_vpc.armada_of_the_damned_vpc
  ]

  tags = {
    Project = "armada-of-the-damned"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.armada_of_the_damned_subnet.id
  route_table_id = aws_route_table.armada_of_the_damned_rt.id

  depends_on = [
    aws_subnet.armada_of_the_damned_subnet,
    aws_route_table.armada_of_the_damned_rt
  ]
}

resource "aws_security_group" "armada_of_the_damned_sg" {
  name        = "armada_of_the_damned__sg"
  description = "Allow All Traffic"
  vpc_id      = aws_vpc.armada_of_the_damned_vpc.id

  ingress {
    description = "Make Way For the Armada Captain"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.armada_captain_ipaddressv4]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  depends_on = [
    aws_vpc.armada_of_the_damned_vpc
  ]

  tags = {
    Project = "armada-of-the-damned"
  }
}

# Establish the BotNet Controller For The Administrator
resource "aws_network_interface" "armada_boastswain_iface" {
  subnet_id       = aws_subnet.armada_of_the_damned_subnet.id
  security_groups = [aws_security_group.armada_of_the_damned_sg.id]

  depends_on = [
    aws_vpc.armada_of_the_damned_vpc,
    aws_subnet.armada_of_the_damned_subnet,
    aws_security_group.armada_of_the_damned_sg
  ]

  tags = {
    Project = "armada-of-the-damned"
  }
}

resource "aws_instance" "armada_boastswain_ec2" {
  ami           = lookup(var.ami, var.aws_region)
  instance_type = var.boastswain_instance_type
  key_name      = "armada-of-the-damned-kp"
  user_data     = file("armada-boastswain-bootstrap.sh")

  network_interface {
    network_interface_id = aws_network_interface.armada_boastswain_iface.id
    device_index         = 0
  }

  depends_on = [
    aws_network_interface.armada_boastswain_iface
  ]

  tags = {
    Project = "armada-of-the-damned"
    Name    = "armada_boastswain_ec2"
  }
}

# Establish the BotNet Zombies For The Administrator
resource "aws_instance" "armada_swine_ec2" {
  count           = var.swine_count
  ami             = lookup(var.ami, var.aws_region)
  instance_type   = var.swine_instance_type
  key_name        = "armada-of-the-damned-kp"
  user_data       = file("armada-swine-bootstrap.sh")
  subnet_id       = aws_subnet.armada_of_the_damned_subnet.id
  security_groups = [aws_security_group.armada_of_the_damned_sg.id]

  depends_on = [
    aws_vpc.armada_of_the_damned_vpc,
    aws_subnet.armada_of_the_damned_subnet,
    aws_security_group.armada_of_the_damned_sg,
    random_string.random
  ]

  tags = {
    Project = "armada-of-the-damned"
    Name    = "armada_swine_ec2"
  }
}
