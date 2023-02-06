#!/bin/bash

# This script makes a call to the Harmonize API end point, initiates the Genesis request, and waits
# for 20 seconds for the messaging public key to be available. If it does not find the key,
# the script will return an error

# Script needs to be called with an argument which is the Harmonize API endpoint
genesis_endpoint=$1/v1/genesis
genesis_file=$2
system_info_endpoint=$1/internal/v1/system/information

# This invokes the genesis REST api
send_genesis_request() {
    curl --location -g --insecure --silent --request POST $genesis_endpoint --header 'Content-Type: application/json' --data @$1
    return $?
}

# Call the function
send_genesis_request $genesis_file
if [ $? -ne 0 ]
then
    #echo "Error: Initiating Genesis failed. Trying again.."
    sleep 5
    send_genesis_request $genesis_file
fi

# Wait for Messaging Public Key for a maximum of 15 seconds
count=0
while [ $count -le 3 ]
do
   messaging_pubkey=$(curl --location -g --silent --request GET "$system_info_endpoint" | jq -r '.notary.messagingPublicKey')
   if [ $messaging_pubkey = "null" ]
   then
       #echo "Notary Messaging public key is not available yet. Trying again.."
       sleep 5
   fi
   # Try next
   ((count=count+1))
done

# Let the caller handle it
echo $messaging_pubkey
