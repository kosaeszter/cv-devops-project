# RDS PostgreSQL instance
resource "aws_db_instance" "postgres" {
  identifier             = "kosaeszter-devops-db"
  engine                 = "postgres"
  engine_version         = "15.3"
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot    = true
  publicly_accessible    = false

    #multi_az = true

  tags = {
    Name = "kosaeszter-devops-rds"
  }
}

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name_prefix = "kosaeszter-rds-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kosaeszter-rds-security-group"
  }
}

# DB subnet group for private subnets
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "kosaeszter-rds-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "kosaeszter-rds-subnet-group"
  }
}

