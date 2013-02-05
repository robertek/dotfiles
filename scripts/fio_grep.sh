#!/bin/bash


simple_parse() {
	cat $1 | grep class=\"th\" | tail -n+2 | tr -s '<' '>' | cut -d'>' -f$2 | tr '>' ':' 
}

[[ $1 == "rmsystem" || $1 == "easyclick" ]] && REGION="kurzy-cz" || REGION="kurzy-svet"

wget http://www.akcie.cz/$REGION/$1 -O tmp >/dev/null 2>&1

simple_parse tmp 5,9,12,18

rm tmp
