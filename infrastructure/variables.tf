variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "fintech-platform-lab"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "asia-south1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "enterprise-gke-cluster"
}
