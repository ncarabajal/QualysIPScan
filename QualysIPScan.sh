#!/bin/bash


read -p "Username: " username
read -s -p "Password: " password
echo ""
read -p "Scan Title: " scanTitle
read -p "IP(s) to be scanned: " ip
read -p "Option Profile ID: " optionID
read -p "Scanner Name: " scanner   

result=$(curl -s -H "X-Requested-With: Curl" -u "${username}:${password}" -X "POST" -d "action=launch&scan_title=${scanTitle}&ip=${ip}&option_id={optionID}&iscanner_name=${scanner}" "https://qualysapi.qualys.com/api/2.0/fo/scan/")

if echo "${result}" | grep -qF "<TEXT>Bad Login/Password</TEXT>"; then
	say "Bad credentials"
	exit 1
fi

if [[ $? != 0 ]]; then
	say "Could not connect" 
	exit 1
fi

say "Scanning Launched" 