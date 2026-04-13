provider "google" {
    project = var.projectid
    region = "us-central1"
}

provider "google" {
    alias= "eu"
    project = var.projectid
    region = "europe-west1"
}

provider "google" {
    alias= "asia"
    project = var.projectid
    region = "asia-south1"
}
