# resource "aws_security_group" "sg" {
#   name        = "sg"
#   description = "Allow SSH and HTTP inbound traffic"
#   vpc_id      = var.vcp_id # attach SG to your VPC

#   # Inbound rules (ingress)
#   ingress {
#     description = "Allow SSH from anywhere"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # ⚠️ allows SSH from everywhere
#   }

#   ingress {
#     description = "Allow HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Outbound rules (egress)
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"           # all protocols
#     cidr_blocks = ["0.0.0.0/0"]  # allow all outbound
#   }

#   tags = {
#     Name = "My-security group"
#   }
# }
# --------------------

resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vcp_id

  tags = {
    Name = "My- security group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "Allow SSH"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description       = "Allow HTTP"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


