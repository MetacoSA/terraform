prefix = "prefix to be attached to provisioned resources"

region = "Region to deploy Vault to, e.g. eu-gb. Please consult IBM cloud document for latest information"
zone = "Zone to deploy to, e.g. 2. Please consult IBM cloud document for latest information"
profile = "Profile used for instantiating the virtual server instance."
          "This has to be a secure execution profile in the format Xz2e-YxZ, e.g. bz2e-1x4."
          " Please consult IBM cloud document for latest information"

ibmcloud_api_key = "ApiKey used to login to IBM cloud to perform the operations"
                   "Reference: https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui#create_user_key"
resource_group = "Resource group onto which the created instances will be attached to"

logging_type = "Logging entity to which the Vault has to send the logs to. syslog or cloudlogs"
cloudlogs_api_key = "ApiKey that grants access to use IBM Cloud Logs for data ingestion. Comment if syslog"
cloudlogs_ingestion_endpoint = "log end point of the connected cloud logs. Found in the 'Endpoints' section. Comment if syslog"

syslog_server_hostname = "hostname of syslog.  Comment this line if using cloudlogs"
syslog_server_port = "Port number(integer) of syslog server. Comment this line if using cloudlogs"
syslog_server_ca_cert_file = "CA certificate file used while establishing TLS session with syslog host. Comment this line if using cloudlogs"

container_registry = "Container regsitry to be used. Example"
container_registry_user_id = "userid to be used to login to container registry"
container_registry_password = "Password to be used to login to container registry"

vault_container_image_repository="Vault image repository""
vault_container_image_sha256="Vault image digest - sha256"
kmsconnect_container_image_repository="kms-ibm image repository"
kmsconnect_container_image_sha256="kms-ibm digest - sha256"

crypto_server_type="Whether it is on cloud hpcs or onpremise grep11. Valid values are hpcs/grep11"

harmonize_api_endpoint = "API endpoint of the Harmonize Core that this vault needs to connect to"
notary_messaging_public_key = "Notary messaging public key obtained after genesis operation"
vault_uuid = "UUID to be associated with the Vault instance"
