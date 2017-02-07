/*=== ROUTING TABLES ===*/
resource "aws_route_table" "public-subnet" {
  vpc_id = "${aws_vpc.environment.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.environment.id}"
  }

  tags {
    Name        = "${var.vpc["tag"]}-public-subnet-route-table"
    Environment = "${lower(var.vpc["tag"])}"
  }
}

resource "aws_route_table_association" "public-subnet" {
  count          = "${length(split(",", lookup(var.azs, var.vpc["region"])))}"
  subnet_id      = "${element(aws_subnet.public-subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-subnet.id}"
}

resource "aws_route_table" "private-subnet" {
  vpc_id = "${aws_vpc.environment.id}"

  tags {
    Name        = "${var.vpc["tag"]}-private-subnet-route-table"
    Environment = "${lower(var.vpc["tag"])}"
  }
}

resource "aws_route_table_association" "private-subnet" {
  count          = "${length(split(",", lookup(var.azs, var.vpc["region"])))}"
  subnet_id      = "${element(aws_subnet.private-subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.private-subnet.id}"
}

resource "aws_route_table" "private-subnet-2" {
  vpc_id = "${aws_vpc.environment.id}"

  tags {
    Name        = "${var.vpc["tag"]}-private-subnet-2-route-table"
    Environment = "${lower(var.vpc["tag"])}"
  }
}

resource "aws_route_table_association" "private-subnet-2" {
  count          = "${length(split(",", lookup(var.azs, var.vpc["region"])))}"
  subnet_id      = "${element(aws_subnet.private-subnets-2.*.id, count.index)}"
  route_table_id = "${aws_route_table.private-subnet-2.id}"
}
