#!/bin/bash
set -e

source src/helpers/logger.sh;
source src/helpers/helm-release-exists.sh;
source src/helpers/check-deps.sh;
source src/helpers/up/usage.sh;
source src/helpers/up/init-args.sh; # contains a cluster dependency
source src/helpers/init-vars.sh;
source src/helpers/up/check-tyk-release.sh;
source src/helpers/expose-services.sh;
source src/helpers/summary.sh;
source src/helpers/helpers.sh;

if $dryRun; then
  source src/helpers/dry-run.sh;
fi

mode=$@
TYKSTACK="tyk-stack";
TYKCP="tyk-cp";
TYKDP="tyk-dp";
TYKGATEWAY="tyk-gateway";

source src/helpers/up/check-vars.sh;
source src/helpers/up/update-helm.sh;

if [[ $TYKSTACK != "$mode" ]] && [[ $TYKCP != "$mode" ]] && [[ $TYKDP != "$mode" ]] && [[ $TYKGATEWAY != "$mode" ]]; then
  logger "$ERROR" "invalid selection";
  usage; exit 1;
fi

if [ "$AWS" == "$cloud" ] || [ "$GCP" == "$cloud" ]  || [ "$AZURE" == "$cloud" ]; then
  logger "$INFO" "standing up $cloud k8s cluster. This may take 10-30 minutes depending on the cloud provider...";
  source src/helpers/up/tf-apply.sh;
fi

source src/main/namespace.sh;

protocol="http";
if [ "$SSL" == "$SSLMode" ]; then
  protocol="https";
  source src/main/ssl/main.sh;
fi

logger "$INFO" "installing $mode in $flavor k8s environment";
source src/main/redis/main.sh;
source "src/main/$mode.sh";

if ! [[ -z $deployments ]]; then
  for deployment in "${deployments[@]}"; do
    if [[ -f "src/deployments/$deployment/main.safe.sh" ]]; then
      source "src/deployments/$deployment/main.safe.sh";
    else
      logger "$INFO" "deployment $deployment not found...skipping";
    fi
  done

  # Update tyk installation after some configuration might have been changed.
  upgradeTyk;
fi

if ! $dryRun; then
  sleep $portsWait;
fi

exposeServices;
printSummaries;
