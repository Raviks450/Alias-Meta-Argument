variable "projectid" { 
default = "qwiklabs-gcp-03-095b7a8a84fc"
}

provider "google" {
    project = var.projectid
    region = "us-central1"
credentials = var.google_creds
}

provider "google" {
    alias= "eu"
    project = var.projectid
    region = "europe-west1"
credentials = var.google_creds
}

provider "google" {
    alias= "asia"
    project = var.projectid
    region = "asia-south1"
credentials = var.google_creds
}

resource "google_compute_instance" "vm1" {
    project = var.projectid
    name = "us-vm"
    machine_type = "e2-medium"
    zone = "us-central1-a"

   boot_disk {
    initialize_params{image = "debian-cloud/debian-11"}
    }

    network_interface {network = "default"}
}

#VM2 will be created last in asia region
resource "google_compute_instance" "vm2" {
    project = var.projectid
    provider = google.eu
    name = "eu-vm"
    machine_type = "e2-medium"
    zone = "europe-west1-b"

   boot_disk {
    initialize_params{image = "debian-cloud/debian-11"}
    }

    network_interface {network = "default"}
    depends_on = [ google_compute_instance.vm1 ]
}

#VM3 will be created last in asia region
resource "google_compute_instance" "vm3" {
    project = var.projectid
    provider = google.asia
    name = "asia-vm"
    machine_type = "e2-medium"
    zone = "asia-south1-a"

   boot_disk {
    initialize_params{image = "debian-cloud/debian-11"}
    }

    network_interface {network = "default"}
    depends_on = [ google_compute_instance.vm2 ]
}
