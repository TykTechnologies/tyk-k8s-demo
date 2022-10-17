#!/bin/bash
set -e

# Print Usage for script
usage() {
  echo "Usage:";
  echo "  ./down.sh [flags]";
  echo -e "\nFlags:";
  echo -e "  -n, --namespace \tstring \t namespace the tyk stack will be installed in, defaults to 'tyk'";
}

source src/helpers/logger.sh
source src/helpers/check-deps.sh;
source src/helpers/init-args.sh;
source src/helpers/port-forward.sh;

cleanPorts;
kubectl delete namespace $namespace;
