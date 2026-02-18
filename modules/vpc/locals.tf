locals {
    vpc_name = "${var.environment}-vpc"
    public_subnet_1_name = "${var.environment}-public-subnet-1"
    public_subnet_2_name = "${var.environment}-public-subnet-2"
    private_subnet_1_name = "${var.environment}-private-subnet-1"
    private_subnet_2_name = "${var.environment}-private-subnet-2"
    public_route_table_name = "${var.environment}-public-route-table"
    private_route_table_name = "${var.environment}-private-route-table"
    internet_gateway_name = "${var.environment}-internet-gateway"
    nat_gateway_name = "${var.environment}-nat-gateway"
}