#!/bin/bash

url="https://pkl.smkn1mejayan.sch.id/api/absensi/hadir"
api_key="fb9f678f7c44e621e56e8bc025201158"
body='{
    "user_id": "87c02a43-2cf5-4aa6-8de8-5d51f991d791",
    "lat": "-6.186052851510576",
    "lon": "106.93250060385081"
}'

response=$(curl -s -o /dev/null -w "%{http_code}" -X POST $url \
    -H "Content-Type: application/json" \
    -H "x-api-key: $api_key" \
    -d "$body")

timestamp=$(date +"%Y-%m-%d %H:%M:%S")
log_file="./absensi.log"

if [ "$response" -eq 200 ]; then
    echo "$timestamp - Absensi berhasil dikirim." >> "$log_file"
else
    echo "$timestamp - Gagal mengirim absensi. Status code: $response" >> "$log_file"
fi

