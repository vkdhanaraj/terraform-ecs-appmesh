resource "aws_appmesh_mesh" "simple" {
  name = "simple"

  spec {
    egress_filter {
      type = "ALLOW_ALL"
    }
  }
}

# Virtual Services---------------------------------------

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

# Virtual Routers----------------------------------------------------

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
          weight       = 100
        }
      }
    }
  }
}

# Virtual Nodes-----------------------------------------------------

resource "aws_appmesh_virtual_node" "productpage" {
  name      = "productpage"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    backend {
      virtual_service {
        virtual_service_name = "details.mydomain"
      }
    }
    backend {
      virtual_service {
        virtual_service_name = "reviews.mydomain"   
      }
    }

    listener {
      port_mapping {
        port     = 9080
        protocol = "http"
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = "productpage"
        namespace_name = "${aws_service_discovery_private_dns_namespace.mydomain.name}"
      }
    }
  }
}


resource "aws_appmesh_virtual_node" "reviews-v1" {
  name      = "reviews-v1"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    listener {
      port_mapping {
        port     = 9080
        protocol = "http"
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = "reviews"
        namespace_name = "${aws_service_discovery_private_dns_namespace.mydomain.name}"
      }
    }
  }
}


resource "aws_appmesh_virtual_node" "details" {
  name      = "details"
  mesh_name = "${aws_appmesh_mesh.simple.id}"

  spec {
    listener {
      port_mapping {
        port     = 9080
        protocol = "http"
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = "details"
        namespace_name = "${aws_service_discovery_private_dns_namespace.mydomain.name}"
      }
    }
  }
}