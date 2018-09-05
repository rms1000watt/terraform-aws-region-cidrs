provider "aws" {
  region = "us-west-2"
}

module "region_cidrs" {
  source = "../.."

  regions = ["us-west-2"]
}

resource "aws_security_group" "0" {
  name        = "test-region-cidrs"
  description = "Allow all traffic from a region"
  vpc_id      = "vpc-713e0914"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${module.region_cidrs.us-west-2}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
