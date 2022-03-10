data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["${module.security_group_ubuntu_server.ubuntu_server_sg_id}"]
  tags = {
    Name    = "Instancia EC2",
    Change  = "True",
    Desliga = "True"
  }
}

resource "aws_eip" "ubuntu_server" {
  instance = aws_instance.ubuntu_server.id
  vpc      = true
}

module "security_group_ubuntu_server" {
  source = "./modules/sg"
}
