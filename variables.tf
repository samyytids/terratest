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

variable "csv_quote" {
  type  = string
  description = "The quote used to demark the data section of a csv"
  default = ""
}

variable "csv_skip_leading_rows" {
  type = int
  description = "The number of rows to skip in a csv"
  default = 1
}
