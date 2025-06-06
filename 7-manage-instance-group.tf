# create manage instance group
# implement lifecycle to prevent recreation of an existing managed group. 
data "google_compute_zones" "available"{
  status = "UP"
}

resource "google_compute_region_instance_group_manager" "manageinstance1" {
  name = "manageinstance1"

  base_instance_name = "mig-1"
  region               = "us-central1"


  distribution_policy_zones = data.google_compute_zones.available.names



  version {
    instance_template  = google_compute_region_instance_template.test-template-1.id
  }

  

  named_port {
    name = "web"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.healthcheck.id
    initial_delay_sec = 300
  }
}



/*resource "google_compute_instance_group" "test-group-1" {
  name        = "test-manage-group-1"
  description = "Terraform test instance group"
  network = google_compute_network.main.id
  zone = "us-central1-a"

  instances = [
    google_compute_instance.instance-test1.id,
    google_compute_instance.instance-test1.id,
    google_compute_instance.instance-test1.id
  ]

  named_port {
    name = "http"
    port = "8080"
  }

  lifecycle {
    create_before_destroy = true
  }
*/
  /*named_port {
    name = "https"
    port = "8443"
  }

  
}*/