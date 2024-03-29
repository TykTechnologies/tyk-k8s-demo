#!/bin/bash
set -e

source src/helpers/logger.sh;
source src/helpers/check-deps.sh;
source src/helpers/expose-services.sh;
source src/helpers/down/usage.sh;
source src/helpers/down/init-args.sh;
source src/helpers/init-vars.sh;

if $dryRun; then
  source src/helpers/dry-run.sh;
fi

cleanPorts;

source src/helpers/down/crds.sh;

if ! $ports; then
  kubectl delete namespace "$namespace";
fi

if [[ $AWS == "$cloud" ]] || [[ $GCP == "$cloud" ]]  || [[ $AZURE == "$cloud" ]] ; then
  logger "$INFO" "destroying $cloud k8s cluster";
  source src/helpers/down/tf-destroy.sh;
fi
