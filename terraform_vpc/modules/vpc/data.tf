data "aws_availability_zones" "available" {
    state = "available"    #or unavailable
    # name = "us-east-1a"
}

# suppose if u need all availability_zone then use plural
# eg: data "aws_availability_zones" "available"

