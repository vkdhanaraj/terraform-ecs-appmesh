resource "aws_appmesh_virtual_router" "reviews" {
  name      = "reviews"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    listener {
      port_mapping {
        port     = 9080
        protocol = "http"
      }
    }
  }
}

#Routes-------------------------------------------------------------

resource "aws_appmesh_route" "reviews" {
  name                = "reviews"
  mesh_name           = "${aws_appmesh_mesh.simple.id}"
  virtual_router_name = "${aws_appmesh_virtual_router.reviews.name}"

  spec {
    http_route {
      match {
        prefix = "/"
      }

      action {
        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.reviews-v1.name}"
          weight       = 20
        }
        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.reviews-v2.name}"
          weight       = 80
        }
      }
    }
  }
}
