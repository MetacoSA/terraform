# Notary contract_generator module

This repository contains the automation required to generate the [contract] (also known as the cidata generally) that will be used while launching the Secure Execution VM on IBM LinuxONE LPAR. This module is generic, and can be called from the on-premise and/or cloud deployments of Metaco Notary.

`compose.grep11/` should be used while deploying Notary on IBM LinuxONE on-premise making use of [GREP11] server to communicate with HSM
`compose.hpcs/` should be used while deploying Notary on IBM LinuxONE [on-cloud] making use of [HPCS] to communicate with HSM

**Not**: While this module can be executed standalone by providing all the needed inputs, it is **recommended** that this be invoked as module from either `../onprem/` or `../oncloud/` directories.

Please refer to `README.md` under `../onprem/`, `../oncloud/` directories

## Bugs
Please report the bugs by opening an issue. Thank you.

[//]: # (Below section has the links to some of the references mentioned above, and this section will not be displayed when the md renders the actual file.)

[contract]: <https://cloud.ibm.com/docs/vpc?topic=vpc-about-contract_se>
[GREP11]: <https://www.ibm.com/docs/en/hpvs/2.1.x?topic=enclaves-integrating-grep11-server>
[HPCS]: <https://cloud.ibm.com/catalog/services/hyper-protect-crypto-services>
[on-cloud]: <https://cloud.ibm.com>
