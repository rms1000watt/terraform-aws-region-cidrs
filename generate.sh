#!/usr/bin/env bash

rm ip-ranges.json
curl -o ip-ranges.json https://ip-ranges.amazonaws.com/ip-ranges.json

# Get regions with command below
# grep region < ip-ranges.json | cut -d '"' -f4  | sort | uniq -c | sort -r | awk '{print $2}' | xargs | pbcopy

for region in us-east-1 eu-west-1 us-west-2 ap-northeast-1 ap-southeast-1 us-west-1 eu-central-1 sa-east-1 ap-southeast-2 GLOBAL eu-west-2 us-east-2 ap-northeast-2 us-gov-west-1 ap-south-1 ca-central-1 cn-north-1 eu-west-3 cn-northwest-1 ap-northeast-3 eu-north-1 me-south-1 us-gov-east-1; do
  jq '.prefixes[] | select(.region == "'"$region"'") | .ip_prefix ' < ip-ranges.json  | jq -s '{"cidrs": .}' > "$region.json"
  jq --arg region "$region" '. + {region: $region}' < "$region.json" > ___ && mv ___ "$region.json"
  jinja2 "region.tf.j2" "$region.json" > "$region.tf"
done
