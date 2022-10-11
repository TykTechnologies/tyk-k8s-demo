#!/bin/bash
set -e

source src/init.sh

echo "Installing $@ in $flavor k8s environment"
case "$@" in
  'tyk-pro')
     source src/update-helm.sh;
     source src/tyk-pro.sh;
     if [ portal ]; then source src/portal.sh; fi;
     if [ operator ]; then source src/operator.sh; fi;
    ;;
  'tyk-cp')
     source src/update-helm.sh;
     source src/tyk-cp.sh;
     if [ portal ]; then source src/portal.sh; fi;
     if [ operator ]; then source src/operator.sh; fi;
    ;;
  'tyk-hybrid')
     source src/update-helm.sh;
     source src/tyk-hybrid.sh;
    ;;
  'tyk-gateway')
     source src/update-helm.sh;
     source src/tyk-gateway.sh;
    ;;
  *) usage; exit 1 ;;
esac
