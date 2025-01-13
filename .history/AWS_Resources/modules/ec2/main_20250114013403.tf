resource "aws_instance" "webserver" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
      name = "webserver"
    }     
    key_name      = "linux"  # for already created keypair

}