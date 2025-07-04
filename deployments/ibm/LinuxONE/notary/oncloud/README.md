## Running Metaco Notary on [Hyper Protect Virtual Server for VPC] on [IBM cloud]

This repository contains the automation required to launch Metaco Notary on [Hyper Protect Virtual Server for VPC] on [IBM cloud]

### Pre-requisites
- Harmonize Core deployed on the Kubernetes
      - Make a note of `notary-bridge` Ingress endpoint
- IAM [ApiKey] required to login to ibmcloud.
- [Hyper Protect Crypto Service(HPCS)] `Standard` plan required for transaction signing
- [ServiceID] Apikey needed to communicate with HPCS. However, IAM [ApiKey] can be reused for this purpose
- [ResourceGroup] created to associate all the created instances
- [IBM Cloud Logs] instance required to push the logs to. 
    - Although a syslog server can also be used,  using [IBM Cloud Logs] is recommended for cloud deployment
- [Hyper Protect Crypto Service(HPCS)] credentials from the `Overview' page of the instance
     - Instance ID
     - EP11 endpoint
     - Use EP11 port: 443
- Credentials of the Container Registry hosting the image
- Image repository 
- Image sha256

### Deploying the Notary
- Rename `my-settings.template.tfvars` to `my-settings.auto.tfvars` 
- Update the values for all the variables in `my-settings.auto.tfvars`
- `terraform init`
- `terraform plan` (Optional)
   - Validate if the resources are right.
- `terraform apply`
     - Type `yes` when it prompts. Alternatively, you may execute `terraform apply --auto-approve`
- This will create Notary instance on [Hyper Protect Virtual Server for VPC] 
- Monitor the logs in the [IBM Log Analysis] dashboard

**Note** This automatically provisions the data volume and attaches to the instance. To maintain the volume across upgrades, please use the same volume.

### Clean-up
Once you are done with using the Notary, you may de-commission it by running `terraform destroy`
This also deletes the attached storage volume

#### Bugs
Please report the bugs by opening an issue. Thank you.

[//]: # (Below section has the links to some of the references mentioned above, and this section will not be displayed when the md renders the actual file.)

[ServiceID]: <https://cloud.ibm.com/docs/account?topic=account-serviceidapikeys&interface=ui>
[IBM Cloud Logs]: <https://cloud.ibm.com/catalog/services/cloud-logs>
[ResourceGroup]: <https://cloud.ibm.com/docs/account?topic=account-rgs&interface=ui>
[Hyper Protect Crypto Service(HPCS)]: <https://cloud.ibm.com/catalog/services/hyper-protect-crypto-services>
[ApiKey]: <https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui#create_user_key>
[Hyper Protect Virtual Server for VPC]: <https://www.ibm.com/cloud/blog/announcements/ibm-hyper-protect-virtual-servers-for-virtual-private-cloud>
[contract]: <https://cloud.ibm.com/docs/vpc?topic=vpc-about-contract_se>
[HPCS]: <https://cloud.ibm.com/catalog/services/hyper-protect-crypto-services>
[IBM cloud]: <https://cloud.ibm.com>                                                           
