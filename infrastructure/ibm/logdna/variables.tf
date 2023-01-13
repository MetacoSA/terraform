variable "ibm_cloud_api_key" {
  type        = string
  description = "IAM API key from ibmcloud"
}

variable "ibm_cloud_region" {
  type        = string
  default     = "eu-de"
  description = "Region in which the LogDNA instance will be deployed"
}

variable "logdna_resource_group" {
  type        = string
  description = "Resource group under which the instances will be created"
}

variable "logdna_instance_name" {
  type        = string
  description = "Name to be given to the LogDNA instance"
}

variable "logdna_log_plan" {
  type        = string
  default     = "7-day"
  description = "Service plan to be used"
  validation {
    condition     = ( var.logdna_log_plan == "7-day"  ||
                      var.logdna_log_plan == "14-day" ||
                      var.logdna_log_plan == "30-day" ||
                      var.logdna_log_plan == "lite" )
    error_message = "Log plan must be 7-day, 14-day, 30-day or lite(not recommended)"
  }
}
