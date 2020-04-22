resource "aws_appmesh_mesh" "simple" {
  name = "simple"

  spec {
    egress_filter {
      type = "ALLOW_ALL"
    }
  }
}
