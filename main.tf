terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "3.85.0"
    }
  }
}

provider "google" {
  project = "ID-from-your-project"
  region = "us-central1"
  zone = "us-central1-a"
}

resource google_compute_instance "gcs1" {
  name = "vm-criada-pelo-tf"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "centos-7"
      size = "35" //tamanho de disco
    }
    auto_delete = false
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  labels = {
    "env" = "tflearning"

  }

  //scheduling {
  //  preemptible = true
  //}

  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }

}


resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 15
  zone = "southamerica-east1-a"
  type = "pd-ssd"
}

//resource "google_compute_attached_disk" "adisk" {
//  disk = google_compute_disk.disk-1.id 
//  instance = google_compute_instance.gcs1.id
  
//}
