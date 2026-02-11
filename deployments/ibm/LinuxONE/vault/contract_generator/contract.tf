# This does tar.gz of contents of compose/ folder
resource "hpcr_tgz" "docker_compose_tgz" {
  folder = "${path.module}/${local.compose_folder}"
}

locals {
  compose_folder = (var.crypto_server_type == "hpcs") ? "compose.hpcs" : "compose.grep11"
  tags = ["gen2", "vault", "metaco"]

  syslog = jsonencode({
    "syslog"  : {
      "hostname" : var.syslog_server_hostname
      "port"     : var.syslog_server_port
      "server"   : file(var.syslog_server_ca_cert_file)
      "cert"     : file(var.syslog_client_ca_cert_file)
      "key"      : file(var.syslog_client_key_file)
    }
  })

  cloudlogs = jsonencode({
    "logRouter" : {
      "iamApiKey" : var.cloudlogs_api_key
      "hostname"  : var.cloudlogs_ingestion_endpoint
    }
  })

  contract = yamlencode({
    "env": merge(
      {
        "type": "env",
        "logging":  jsondecode((var.logging_type == "cloudlogs") ? local.cloudlogs : local.syslog),
        "env" : {
          "notary_messaging_public_key"   : var.notary_messaging_public_key
          "harmonize_api_endpoint"        : var.harmonize_api_endpoint
        }
      },
      var.registry_cacert_file != "" ? {
        "cacerts" : [
          {
            "certificate" : base64encode(trimspace(file(var.registry_cacert_file)))
          }
        ]
      } : {}
    ),
    "workload": {
      "type": "workload",
      "compose": {
        "archive": resource.hpcr_tgz.docker_compose_tgz.rendered
      },
      "auths": {
        (var.container_registry): {
          "username": var.container_registry_user_id
          "password": var.container_registry_password
        },
      },
      "env": {
        "vault_image_repository"       : format("%s/%s", var.container_registry, var.vault_container_image_repository)
        "vault_image_sha256"           : var.vault_container_image_sha256
        "kmsconnect_image_repository"  : format("%s/%s", var.container_registry, var.kmsconnect_container_image_repository)
        "kmsconnect_image_sha256"      : var.kmsconnect_container_image_sha256
        "vault_id"                     : var.vault_uuid
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
