#!/bin/bash
set -e

helm install tyk-redis bitnami/redis  --version 17.3.2 \
  -n $namespace \
  --set "auth.password=topsecretpassword" \
  --wait
