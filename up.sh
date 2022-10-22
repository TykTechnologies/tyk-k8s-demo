#!/bin/bash
set -e

source src/main/helpers/logger.sh
source src/main/helpers/check-deps.sh;
source src/main/helpers/usage.sh;
source src/main/helpers/init-vars.sh;
source src/main/helpers/init-args.sh;
source src/main/helpers/helm-release-exists.sh;
source src/main/helpers/check-tyk-release.sh;
source src/main/helpers/port-forward.sh;
source src/main/helpers/deployments-args.sh;

TYKPRO="tyk-pro";
TYKCP="tyk-cp";
TYKHYBRID="tyk-hybrid";
TYKGATEWAY="tyk-gateway";

mode=$@
if [[ $TYKPRO != $mode ]] && [[ $TYKCP != $mode ]] && [[ $TYKHYBRID != $mode ]] && [[ $TYKGATEWAY != $mode ]]; then
  logger $ERROR "invalid selection";
  usage; exit 1;
fi

logger $INFO "Installing $mode in $flavor k8s environment";
source src/main/helpers/update-helm.sh;
source src/main/helpers/check-vars.sh;
source "src/main/$mode.sh";

if ! [[ -z $deployments ]]; then
  for deployment in "${deployments[@]}"; do
    if [[ -f "src/deployments/$deployment/main.sh" ]]; then
      source "src/deployments/$deployment/main.sh";
    else
      logger $INFO "deployment $deployment not found...skipping";
    fi
  done
fi

exposePorts;
