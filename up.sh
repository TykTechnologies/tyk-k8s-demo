#!/bin/bash
set -e

source src/helpers/logger.sh;
source src/helpers/helm-release-exists.sh;
source src/helpers/check-deps.sh;
source src/helpers/up/usage.sh;
source src/helpers/init-vars.sh;
source src/helpers/up/init-args.sh;
source src/helpers/up/check-tyk-release.sh;
source src/helpers/deployments-args.sh;
source src/helpers/expose-services.sh;
source src/helpers/summary.sh;

TYKSTACK="tyk-stack";
TYKCP="tyk-cp";
TYKWORKER="tyk-dp";
TYKGATEWAY="tyk-gateway";

mode=$@
if [[ $TYKSTACK != "$mode" ]] && [[ $TYKCP != "$mode" ]] && [[ $TYKWORKER != "$mode" ]] && [[ $TYKGATEWAY != "$mode" ]]; then
  logger "$ERROR" "invalid selection";
  usage; exit 1;
fi

if $dryRun; then
  source src/helpers/dry-run.sh;
fi

if [ "$AWS" == "$cloud" ] || [ "$GCP" == "$cloud" ]  || [ "$AZURE" == "$cloud" ]; then
  logger "$INFO" "standing up $cloud k8s cluster. This may take 10-30 minutes depending on the cloud provider...";
  source src/helpers/up/tf-apply.sh;
fi

logger "$INFO" "installing $mode in $flavor k8s environment";
source src/helpers/up/update-helm.sh;
source src/helpers/up/check-vars.sh;
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
  setVerbose;
  helm upgrade "$tykReleaseName" "$TYK_HELM_CHART_PATH/$chart" \
    --namespace "$namespace" \
    "${deploymentsArgs[@]}" \
    --atomic \
    --wait > /dev/null
  unsetVerbose;
fi

if ! $dryRun; then
  sleep $portsWait;
fi

exposeServices;
printSummaries;
