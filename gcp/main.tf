provider "google" {
  credentials = file("credentials.json")
  project     = "your-gcp-project-id"   # Replace with your actual GCP project ID
  region      = "us-central1"
}

resource "google_compute_instance_template" "backend_template" {
  name_prefix  = "backend-template-"
  machine_type = "e2-micro"

  disk {
    boot         = true
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<EOT
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    echo "Welcome to GCP Backend" > /var/www/html/index.html
    systemctl restart apache2
  EOT
}

resource "google_compute_region_instance_group_manager" "backend_mig" {
  name               = "backend-mig"
  region             = "us-central1"
  base_instance_name = "backend-instance"

  version {
    instance_template = google_compute_instance_template.backend_template.self_link
  }

  target_size = 2
}

resource "google_compute_global_address" "backend_ip" {
  name = "backend-ip"
}

resource "google_compute_health_check" "default" {
  name               = "backend-health-check"
  timeout_sec        = 5
  check_interval_sec = 10

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend_service" {
  name = "backend-service"
  backend {
    group = google_compute_region_instance_group_manager.backend_mig.instance_group
  }

  health_checks = [google_compute_health_check.default.self_link]
}

resource "google_compute_url_map" "backend_url_map" {
  name            = "backend-url-map"
  default_service = google_compute_backend_service.backend_service.self_link
}

resource "google_compute_target_http_proxy" "backend_http_proxy" {
  name    = "backend-http-proxy"
  url_map = google_compute_url_map.backend_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "backend_forwarding_rule" {
  name       = "backend-forwarding-rule"
  target     = google_compute_target_http_proxy.backend_http_proxy.self_link
  port_range = "80"
  ip_address = google_compute_global_address.backend_ip.address
}
 
