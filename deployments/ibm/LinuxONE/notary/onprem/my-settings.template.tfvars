libvirt_host="Your libvirt host name"
libvirt_user="User name authorized by a SSH server in your libvirt host"

prefix="prefix to be attached to provisioned resources"
vsi_hostname="hostname to be attached to the created notary instance"

container_registry="Container regsitry to be used"
container_registry_user_id="userid to be used to login to container registry"
container_registry_password="Password to be used to login to container registry"

notary_container_image_repository="Notary image repository"
notary_container_image_sha256="Notary image digest - sha256"
kmsconnect_container_image_repository="kms-ibm image repository""
kmsconnect_container_image_sha256="kms-ibm image digest - sha256""

logging_type = "Logging entity to which the Notary has to send the logs to. syslog or cloudlogs"
cloudlogs_api_key = "ApiKey that grants access to use IBM Cloud Logs for data ingestion. Comment if syslog"
cloudlogs_ingestion_endpoint = "log end point of the connected cloud logs. Found in the 'Endpoints' section. Comment if syslog"

syslog_server_hostname="hostname of syslog.  Comment this line if using cloudlogs"
syslog_server_port="Port number(integer) of syslog server. Comment this line if using cloudlogs"
syslog_server_ca_cert_file="CA certificate file used while establishing TLS session with syslog host. Comment this line if using cloudlogs"

hpvs_qcow2_image="Absolute path to the downloaded Hyper Protect Container Runtime image"
hpvs_contract_encryption_cert="Absolute path to the downloaded Hyper Protect Container Runtime encryption certificate file"

data_volume_size="Size of the data volume that is to be attached to the instance. Must be >10G"
storage_pool_name = "name of the storage pool in libvirt host created using virsh"

crypto_server_type="Whether it is on cloud hpcs or onpremise grep11. Valid values are hpcs/grep11"

volume_encryption_seed_phrase_user="encryption seed phrase part of env that will be used on mounted data volume"
volume_encryption_seed_phrase_workload="encryption seed phrase part of workload that will be used on mounted data volume"

harmonize_notary_bridge_endpoint="Bridge endpoint obtained from the installation of core components"
