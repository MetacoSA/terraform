# This does tar.gz of contents of compose/ folder
resource "hpcr_tgz" "docker_compose_tgz" {
  folder = "${path.module}/${local.compose_folder}"
}

locals {
  compose_folder = (var.crypto_server_type == "hpcs") ? "compose.hpcs" : "compose.grep11"
  tags = ["gen2", "notary", "metaco"]

  syslog = jsonencode({
    "syslog"  : {
      "hostname" : var.syslog_server_hostname
      "port"     : var.syslog_server_port
      "server"   : file(var.syslog_server_ca_cert_file)
    }
  })

  cloudlogs = jsonencode({
    "logRouter" : {
      "iamApiKey" : var.cloudlogs_api_key
      "hostname"  : var.cloudlogs_ingestion_endpoint
    }
  })

  contract = yamlencode({
    "env": {
      "type": "env",
      "logging":  jsondecode((var.logging_type == "cloudlogs") ? local.cloudlogs : local.syslog),
      "env" : {
        "harmonize_notary_bridge_endpoint" : var.harmonize_notary_bridge_endpoint
       }
      "volumes":  {
        "data": {
          "seed": var.volume_encryption_seed_phrase_user
        }
     }
  },
  "workload": {
      "type": "workload",
      "compose": {
        "archive": resource.hpcr_tgz.docker_compose_tgz.rendered
      },
      "auths": {
        (var.container_registry): {
          "username": var.container_registry_user_id
          "password": var.container_registry_password
        }
      },
      "volumes": {
        "data": {
          "mount": "/mnt/data",
          "seed": var.volume_encryption_seed_phrase_workload
        }
      },
      "env": {
        "notary_image_repository"          : format("%s/%s", var.container_registry, var.notary_container_image_repository)
        "notary_image_sha256"              : var.notary_container_image_sha256
        "kmsconnect_image_repository"      : format("%s/%s", var.container_registry, var.kmsconnect_container_image_repository)
        "kmsconnect_image_sha256"          : var.kmsconnect_container_image_sha256
      }
    }
  })
}

resource "hpcr_contract_encrypted" "contract_encrypted" {
  contract = local.contract
  cert     = var.hpvs_contract_encryption_cert
}

# This will be used by the caller of this module
output "user_data" {
  value = resource.hpcr_contract_encrypted.contract_encrypted.rendered
}

output "user_data_plan" {
  value = local.contract
  sensitive = true
}
