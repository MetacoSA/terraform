# This invokes the genesis with the genesis json
resource "null_resource" "start_genesis" {
  provisioner "local-exec" {
    command = <<EOT
      messaging_pubkey=$(./run_genesis.sh ${var.harmonize_api_endpoint} ${var.genesis_file})
      if [ $messaging_pubkey == "null" ]
      then
          echo "Genesis Error. Messaging public key is null"
          exit 1
      else
          echo "Genesis Success. Messaging public key is:"
          echo $messaging_pubkey
      fi
    EOT
  }
}
