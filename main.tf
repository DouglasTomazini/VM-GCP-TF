terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "3.85.0"
    }
  }
}
#--------------------------Dados de conexão com o projeto---------------------------------------------
provider "google" {
  project = "ID-from-your-project"
  region = "us-central1"
  zone = "us-central1-a"
}
#--------------------------Criando a VM---------------------------------------------
resource google_compute_instance "gcs1" {
  name = "vm-criada-pelo-tf"
  machine_type = "n1-standard-1" #tipo de máquina
  zone         = "us-central1-a" #zona do servidor

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "centos-7" #SO instalado
      size = "35" #tamanho de disco
    }
    auto_delete = false
  }
  network_interface {
    network = "default"

    access_config {
      # Ephemeral public IP
    }
  }

  labels = {
    "env" = "tflearning"

  }


  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }

}


resource "google_compute_disk" "disk-1" { #adicionando disco
  name = "disk-1"
  size = 15
  zone = "southamerica-east1-a"
  type = "pd-ssd"
}

#resource "google_compute_attached_disk" "adisk" {  # fazendo o 'atach' do disco ao projeto
#  disk = google_compute_disk.disk-1.id 
##  instance = google_compute_instance.gcs1.id  
#}
