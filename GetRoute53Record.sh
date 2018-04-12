#!/bin/bash

if [ "$1" == "" ]; then
echo "Domain was not informed"
echo ""
echo "usage: GetRoute53Record <DOMAIN>"
echo ""
exit 1
fi
zonename=$1
hostedzoneid=$(aws route53 list-hosted-zones | jq -r ".HostedZones[] | select(.Name == \"$zonename.\") | .Id" | cut -d'/' -f3)
aws route53 list-resource-record-sets --hosted-zone-id $hostedzoneid --output json | jq -jr '.ResourceRecordSets[] | "\(.Name) \t\(.TTL) \t\(.Type) \t\(.ResourceRecords[].Value)\n"'
