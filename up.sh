#!/bin/bash
set -e

source src/helpers/logger.sh
source src/helpers/check-deps.sh;
source src/helpers/usage.sh;
source src/helpers/init-vars.sh;
source src/helpers/init-args.sh;
source src/helpers/helm-release-exists.sh
source src/helpers/check-tyk-release.sh

TYKPRO="tyk-pro";
TYKCP="tyk-cp";
TYKHYBRID="tyk-hybrid";
TYKGATEWAY="tyk-gateway";

mode=$@
if [[ $TYKPRO != $mode ]] && [[ $TYKCP != $mode ]] && [[ $TYKHYBRID != $mode ]] && [[ $TYKGATEWAY != $mode ]]; then
  usage;
  logger $ERROR "invalid selection"
  exit 1;
fi

logger $INFO "Installing $mode in $flavor k8s environment";
source src/helpers/update-helm.sh;
source src/helpers/check-vars.sh;
source "src/$mode.sh";

if $portal && ([[ $TYKPRO == $mode ]] || [[ $TYKCP == $mode ]]); then
  logger $DEBUG "Installing enterprise portal";
  source src/portal.sh;
fi

if $operator && ([[ $TYKPRO == $mode ]] || [[ $TYKCP == $mode ]] || [[ $TYKGATEWAY == $mode ]]); then
  logger $DEBUG "Installing operator";
  source src/operator.sh;
fi
