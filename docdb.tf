resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  skip_final_snapshot     = true

  vpc_security_group_ids  =  [aws_security_group.allows_docdb.id]
  db_subnet_group_name    =  aws_docdb_subnet_group.docdb_subnet_group.name
}

# in which VPC , in which subnet it has to be created is not mentioned


# creates subnet group
resource "aws_db_subnet_group" "docdb_subnet_group" {
  name                = "roboshop-docdb-${var.ENV}-subnetgroup"
  subnet_ids          = [ data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS ]

  tags = {
    Name = "roboshop-docdb-${var.ENV}-subnetgroup"
  }
} 
