#!/bin/bash
set -e

helm install tyk-$1-postgres bitnami/postgresql --version 11.9.7 \
  -n $namespace \
  --set "auth.database=$1" \
  --set "auth.postgresPassword=topsecretpassword" \
  --wait
