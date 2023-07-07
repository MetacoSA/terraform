prefix = "Prefix to be attached to provisioned resources"

region = "Region to deploy Notary to, e.g. eu-gb. Please consult IBM cloud document for latest information"
zone = "Zone to deploy to, e.g. 2. Please consult IBM cloud document for latest information"
profile = "Profile used for instantiating the virtual server instance. This has to be a secure execution profile in the format Xz2e-YxZ, e.g. bz2e-1x4. Please consult IBM cloud document for latest information"

container_registry = "Container regsitry to be used. Example: de.icr.io"
container_registry_user_id = "userid to be used to login to container registry"
container_registry_password = "Password to be used to login to container registry"
container_image_repository = "Container image repository. Example: metaco/approval-notary"
container_image_sha256 = "Container image sha256"

logging_type = "Logging entity to which the Notary has to send the logs to. syslog or logdna"
syslog_server_hostname = "hostname of syslog.  Comment this line if using logdna"
syslog_server_port = "Port number(integer) of syslog server. Comment this line if using logdna"
syslog_server_ca_cert_file = "CA certificate file used while establishing TLS session with syslog host. Comment this line if using logdna"

logdna_ingestion_key = "Ingestion key of the logdna instance created in ibmcloud. Comment this line if using syslog"
# Ingestion key is found in "Linux/ubuntu" section of `Logging sources` tab of "IBM Log Analysis" instance in cloud.ibm.com
logdna_log_endpoint = "log end point of the connected logdna instance. It will be syslog-a.<region>.logging.cloud.ibm.com. Comment this line if using syslog"

data_volume_size = "Size of the data volume that is to be attached to the instance. Must be >10G"

crypto_server_type = "Whether it is on cloud hpcs or onpremise grep11. Valid values are hpcs/grep11"
crypto_server_ep11_host = "Domain or the ip address of the GREP11 server host"
crypto_server_ep11_port = "Port on which GREP11 server is listening. Usually it is: 9876"
crypto_server_instance_id = "Instance id of Hyper Protect Crypto Service instance"
crypto_server_access_api_key = "Access key(apikey) to be used to communicate with Hyper Protect Crypto Service"

volume_encryption_seed_phrase_user = "encryption seed phrase part of env that will be used on mounted data volume"
volume_encryption_seed_phrase_workload = "encryption seed phrase part of workload that will be used on mounted data volume"

harmonize_notary_bridge_endpoint = "Bridge endpoint obtained from the installation of core components"
