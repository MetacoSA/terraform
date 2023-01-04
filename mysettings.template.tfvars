registry_id       = #fillme
registry_password = #fillme
endpoints={
        frontend = "metaco.example.com"
        api      = "api-metaco.example.com"
        auth     = "auth-metaco.example.com"
}
use_tls = false # Recomended until we add certificate generation
harmonize_helm_templates=[
  {
    path: "templates/globals.yaml"
    vars: {
        clientId = "ibmId"
    }
  },  
  {
    path: "templates/ethereum.yaml"
    vars: {
        ethereum_network_name = "testnet-goerli"
        ethereum_node_url     = #fillme
    }
  }
]
  