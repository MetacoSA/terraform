# This does tar.gz of contents of compose/ folder
resource "hpcr_tgz" "docker_compose_tgz" {
  folder = "${path.module}/${local.compose_folder}"
}

# This generates a random UUID to be used as Vault ID
resource "random_uuid" "vault_id" {
}

locals {
  compose_folder = (var.crypto_server_type == "hpcs") ? "compose.hpcs" : "compose.grep11"
  tags = ["gen2", "vault", "metaco"]
  contract = yamlencode({
    "env": { 
      "type": "env",
      "logging" : {
        "logDNA" : {
          "ingestionKey" : var.logdna_ingestion_key
          "hostname"     : var.logdna_log_endpoint
        }
      },
      "env" : (var.crypto_server_type == "hpcs") ? {
        "crypto_server_access_api_key"  : var.crypto_server_access_api_key
        "crypto_server_instance_id"     : var.crypto_server_instance_id
        "notary_messaging_public_key"   : var.notary_messaging_public_key
        "crypto_server_ep11_endpoint"   : format("%s:%s", var.crypto_server_ep11_host, var.crypto_server_ep11_port)
      } : {
        "notary_messaging_public_key"   : var.notary_messaging_public_key
        "crypto_server_ep11_endpoint"   : format("%s:%s", var.crypto_server_ep11_host, var.crypto_server_ep11_port)
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
        },
      },
      "env": {
        "image_repository"       : format("%s/%s", var.container_registry, var.container_image_repository)
        "image_sha256"           : var.container_image_sha256
        "vault_id"               : random_uuid.vault_id.id
        "harmonize_api_endpoint" : var.harmonize_api_endpoint
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
