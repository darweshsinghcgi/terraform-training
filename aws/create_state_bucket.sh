#!/bin/bash
set -e

if [[ $(aws s3 ls | grep ${S3_BUCKET_NAME}) ]]; then
  echo "Bucket already exists."
else
  aws s3 mb s3://${S3_BUCKET_NAME}
fi
