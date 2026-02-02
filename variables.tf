variable "project_id" {
  type        = string
  description = "The id associated with this configuration"
  nullable    = false
  sensitive   = true
}

variable "reader_domain" {
  type        = string
  description = "The domain to provide read only access to"
  nullable    = false
  sensitive   = true
}
