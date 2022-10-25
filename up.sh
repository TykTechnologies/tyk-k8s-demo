#!/bin/bash
set -e

source src/helpers/logger.sh;
source src/helpers/check-deps.sh;
source src/helpers/usage.sh;
source src/helpers/init-vars.sh;
source src/helpers/init-args.sh;
source src/helpers/helm-release-exists.sh;
source src/helpers/check-tyk-release.sh;
source src/helpers/expose-services.sh;
source src/helpers/summary.sh;
source src/helpers/deployments-args.sh;

TYKPRO="tyk-pro";
TYKCP="tyk-cp";
TYKWORKER="tyk-worker";
TYKGATEWAY="tyk-gateway";

mode=$@
if [[ $TYKPRO != $mode ]] && [[ $TYKCP != $mode ]] && [[ $TYKWORKER != $mode ]] && [[ $TYKGATEWAY != $mode ]]; then
  logger $ERROR "invalid selection";
  usage; exit 1;
fi

if $dryRun; then
  source src/helpers/dry-run.sh;
fi

logger $INFO "Installing $mode in $flavor k8s environment";
source src/helpers/update-helm.sh;
source src/helpers/check-vars.sh;
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

if ! $dryRun; then
  sleep $portsWait;
fi
exposePorts;

printSummaries;
