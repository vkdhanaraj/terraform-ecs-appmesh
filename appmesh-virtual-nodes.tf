
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


resource "aws_appmesh_virtual_node" "reviews-v2" {
  name      = "reviews-v2"
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
        attributes  = {
        	ECS_SERVICE_NAME = "reviews-v2"
        }
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


resource "aws_appmesh_virtual_node" "ratings" {
  name      = "ratings"
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
        service_name   = "ratings"
        namespace_name = "${aws_service_discovery_private_dns_namespace.mydomain.name}"
      }
    }
  }
}