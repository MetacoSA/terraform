libvirt_host="Your libvirt host name"
libvirt_user="User name authorized by a SSH server in your libvirt host"

prefix="prefix to be attached to provisioned resources"
vsi_hostname="hostname to be attached to the created vault instance"

logging_type = "Logging entity to which the Vault has to send the logs to. syslog or cloudlogs"
cloudlogs_api_key = "ApiKey that grants access to use IBM Cloud Logs for data ingestion. Comment if syslog"
cloudlogs_ingestion_endpoint = "log end point of the connected cloud logs. Found in the 'Endpoints' section. Comment if syslog"

syslog_server_hostname="hostname of syslog.  Comment this line if using cloudlogs"
syslog_server_port="Port number(integer) of syslog server. Comment this line if using cloudlogs"
syslog_server_ca_cert_file="CA certificate file used while establishing TLS session with syslog host. Comment this line if using cloudlogs"

container_registry="Container regsitry to be used"
container_registry_user_id="userid to be used to login to container registry"
container_registry_password="Password to be used to login to container registry"

vault_container_image_repository="Vault image repository""
vault_container_image_sha256="Vault image digest - sha256"
kmsconnect_container_image_repository="kms-ibm image repository"
kmsconnect_container_image_sha256="kms-ibm digest - sha256"

hpvs_qcow2_image="Absolute path to the downloaded Hyper Protect Container Runtime image"
hpvs_contract_encryption_cert="Absolute path to the downloaded Hyper Protect Container Runtime encryption certificate file"

crypto_server_type = "grep11"
harmonize_api_endpoint="API endpoint obtained from the installation of core components"
vault_uuid = "UUID to be associated with the Vault instance"
