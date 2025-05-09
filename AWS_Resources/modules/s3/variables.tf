variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable or disable bucket versioning"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Default encryption algorithm for the S3 bucket"
  type        = string
  default     = "AES256"
}
