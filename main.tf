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
resource "aws_key_pair" "armada_boastswain_kp" {
  key_name   = "armada_boastswain_kp"
  public_key = file("~/.ssh/terraform.pub")
}

resource "aws_instance" "armada_boastswain_ec2" {
  ami             = lookup(var.ami, var.aws_region)
  instance_type   = var.boastswain_instance_type
  key_name        = "armada_boastswain_kp"
  user_data       = file("armada-boastswain-bootstrap.sh")
  subnet_id       = aws_subnet.armada_of_the_damned_subnet.id
  security_groups = [aws_security_group.armada_of_the_damned_sg.id]

  depends_on = [
    aws_vpc.armada_of_the_damned_vpc,
    aws_subnet.armada_of_the_damned_subnet,
    aws_security_group.armada_of_the_damned_sg
  ]

  tags = {
    Project = "armada-of-the-damned"
    Name    = "armada_boastswain_ec2"
  }
}

resource "null_resource" "start-bringyourownbotnet" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/terraform")
    host        = aws_instance.armada_boastswain_ec2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "git clone https://github.com/trevorpatch73/byob",
      "cd byob/web-gui",
      "sudo kill -9 $(ps -A | grep python | awk '{print $1}')",
      "sudo yum -y install python36",
      "sudo yum -y install python3-pip",
      "chmod +x get-docker.sh",
      "./get-docker.sh",
      "sudo usermod -aG docker $USER",
      "sudo chmod 666 /var/run/docker.sock",
      "python3 -m pip install CMake==3.18.4",
      "python3 -m pip install -r requirements.txt",
      "cd docker-pyinstaller",
      "docker build -f Dockerfile-py3-amd64 -t nix-amd64 .",
      "docker build -f Dockerfile-py3-i386 -t nix-i386 .",
      "docker build -f Dockerfile-py3-win32 -t win-x32 .",
      "cd ..",
      "python3 run.py"
    ]
  }
  depends_on = [
    aws_instance.armada_boastswain_ec2
  ]
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
    aws_security_group.armada_of_the_damned_sg
  ]

  tags = {
    Project = "armada-of-the-damned"
    Name    = "armada_swine_ec2"
  }
}



