#!/bin/bash
set -e

if [ -f "./jumpbox_key" ]; then
  echo "Key already exists. Please delete the file with caution and re-run if you want a new key."
else
  ssh-keygen -f jumpbox_key -t rsa -b 4096
fi
