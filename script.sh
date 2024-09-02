#!/bin/bash

timestamp=$(date +"%Y-%m-%d %H:%M:%S")
log_file="/home/kurniawan/Documents/Project/auto-absensi-pkl/absensi.log"

echo "$timestamp - Script started" >> "$log_file"

url="https://pkl.smkn1mejayan.sch.id/api/absensi/hadir"
api_key="fb9f678f7c44e621e56e8bc025201158"
body='{
    "user_id": "87c02a43-2cf5-4aa6-8de8-5d51f991d791",
    "lat": "-6.186052851510576",
    "lon": "106.93250060385081"
}'

response=$(curl -s -X POST $url \
    -H "Content-Type: application/json" \
    -H "x-api-key: $api_key" \
    -d "$body")

# Log the raw response
echo "$timestamp - API response: $response" >> "$log_file"

# Extract success and message fields from the response
success=$(echo $response | /usr/bin/jq -r '.success')
message=$(echo $response | /usr/bin/jq -r '.message')

if [ "$success" = "true" ]; then
    echo "$timestamp - Absensi berhasil dikirim." >> "$log_file"
else
    echo "$timestamp - Gagal mengirim absensi. Pesan: $message" >> "$log_file"
fi

echo "$timestamp - Script ended" >> "$log_file"



