libvirt_host="Your libvirt host name"
libvirt_user="User name authorized by a SSH server in your libvirt host"

prefix="prefix to be attached to provisioned resources"
vsi_hostname="hostname to be attached to the created vault instance"

container_registry="Container regsitry to be used. Example: de.icr.io"
container_image_repository="Container image repository. Example: metaco/vault-releases"
container_image_sha256="Container image sha256"
container_registry_user_id="userid to be used to login to container registry"
container_registry_password="Password to be used to login to container registry"

logdna_ingestion_key="Ingestion key of the logdna instance created in ibmcloud"
# Ingestion key is found in "Linux/ubuntu" section of `Logging sources` tab of "IBM Log Analysis" instance in cloud.ibm.com
logdna_log_endpoint="log end point of the connected logdna instance. It will be syslog-a.<region>.logging.cloud.ibm.com"

hpvs_qcow2_image="Absolute path to the downloaded Hyper Protect Container Runtime image"
hpvs_contract_encryption_key="Absolute path to the encryption key matching Hyper Protect Container Runtime image"
data_volume_size="Size of the data volume that is to be attached to the instance. Must be >10G"
storage_pool_name = "name of the storage pool in libvirt host created using virsh"

crypto_server_ep11_host="Domain or the ip address of the GREP11 server host"
crypto_server_ep11_port="Port on which GREP11 server is listening. Usually it is: 9876"
crypto_server_type="Whether it is on cloud hpcs or onpremise grep11. Valid values are hpcs/grep11"

harmonize_api_endpoint="API endpoint obtained from the installation of core components"
