#!/bin/bash
set -e

if [ -d "./infrastructure/.terraform" ]; then
  echo "There seems to already be a .terraform directory."
fi

# DEPLOY INFRASTRUCTURE
pushd infrastructure
  terraform init
  terraform plan
  terraform apply -auto-approve
popd
