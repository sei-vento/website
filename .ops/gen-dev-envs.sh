#!/usr/bin/env bash

OP_VAULT="app-ventoventures-dev"
OP_ITEM="ventoventures-secrets-devl"

###

filename=".env"
envfile_content=$(op item get $OP_ITEM --vault $OP_VAULT --format json | jq -r '.fields[] | select(has("value")) | [.label,.value] | join("=")')

printf "$envfile_content\n" > $filename
echo "Writed env file $filename"
