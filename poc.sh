#!/bin/bash
set -e

source src/init.sh

case "$@" in
  'tyk-pro')
     echo "Installing tyk-pro in $flavor k8s environment"
     source src/tyk-pro.sh
    ;;
  'tyk-cp')
     echo "Installing tyk-cp in $flavor k8s environment"
    ;;
  'tyk-hybrid')
     echo "Installing tyk-hybrid in $flavor k8s environment"
    ;;
  'tyk-gateway')
     echo "Installing tyk-hybrid in $flavor k8s environment"
    ;;
  *) usage; exit 1 ;;
esac