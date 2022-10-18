#!/bin/bash
set -e

source src/main/helpers/logger.sh
source src/main/helpers/check-deps.sh;
source src/main/helpers/down/usage.sh;
source src/main/helpers/down/init-args.sh;
source src/main/helpers/port-forward.sh;

cleanPorts;

if ! $ports; then
  kubectl delete namespace $namespace;
fi
