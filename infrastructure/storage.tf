

resource "google_storage_bucket" "backup" {
  name          = "enterprise-backups-${var.project_id}"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

}
