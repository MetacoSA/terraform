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

  logdna = jsonencode({
    "logDNA" : {
      "ingestionKey" : var.logdna_ingestion_key
      "hostname"     : var.logdna_log_endpoint
    }
  })

  contract = yamlencode({
    "env": {
      "type": "env",
      "logging":  jsondecode((var.logging_type == "logdna") ? local.logdna : local.syslog),
      "env" : (var.crypto_server_type == "hpcs") ? {
        "crypto_server_access_api_key" : var.crypto_server_access_api_key
        "crypto_server_instance_id"    : var.crypto_server_instance_id
        "crypto_server_ep11_host"      : var.crypto_server_ep11_host
        "crypto_server_ep11_port"      : var.crypto_server_ep11_port
       } : {
        "crypto_server_ep11_host"      : var.crypto_server_ep11_host
        "crypto_server_ep11_port"      : var.crypto_server_ep11_port
      },
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
        "image_repository"                 : format("%s/%s", var.container_registry, var.container_image_repository)
        "image_sha256"                     : var.container_image_sha256
        "harmonize_notary_bridge_endpoint" : var.harmonize_notary_bridge_endpoint
      }
    }
  })
}

resource "hpcr_contract_encrypted" "contract_encrypted" {
  contract = local.contract
  cert     = file(var.hpvs_contract_encryption_key)
}

# This will be used by the caller of this module
output "user_data" {
  value = resource.hpcr_contract_encrypted.contract_encrypted.rendered
}

output "user_data_plan" {
  value = local.contract
  sensitive = true
}
