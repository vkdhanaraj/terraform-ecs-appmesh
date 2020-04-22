resource "aws_appmesh_virtual_service" "productpage" {
  name      = "productpage.mydomain"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    provider {
      virtual_node {
        virtual_node_name = "${aws_appmesh_virtual_node.productpage.name}"
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "details" {
  name      = "details.mydomain"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    provider {
      virtual_node {
        virtual_node_name = "${aws_appmesh_virtual_node.details.name}"
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "reviews" {
  name      = "reviews.mydomain"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    provider {
      virtual_router {
        virtual_router_name = "${aws_appmesh_virtual_router.reviews.name}"
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "ratings" {
  name      = "ratings.mydomain"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    provider {
      virtual_node {
        virtual_node_name = "${aws_appmesh_virtual_node.ratings.name}"
      }
    }
  }
}
