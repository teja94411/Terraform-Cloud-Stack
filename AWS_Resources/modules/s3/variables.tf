variable "new_bucket" {
    description = "creating new s3 bucket"
    default = "royal74523" 
}

variable "encryption_algorithm" {
  description = "Default encryption algorithm for the S3 bucket"
  default     = "AES256" # Default encryption algorithm
}