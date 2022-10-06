#!/bin/bash
set -e

sleep 1;

ID=$(kubectl get ns $namespace -o=jsonpath='{.metadata.annotations.openshift\.io\/sa\.scc\.uid-range}' | rev | cut -c7- | rev);

# Set Redis args
# --set "master.podSecurityContext.fsGroup=$ID" \
# --set "master.containerSecurityContext.runAsUser=$ID" \
# --set "replica.podSecurityContext.fsGroup=$ID" \
# --set "replica.containerSecurityContext.runAsUser=$ID" \

# Set Mongo args
# --set "podSecurityContext.fsGroup=$ID" \
# --set "containerSecurityContext.runAsUser=$ID"

# Set Postgres args
# --set "auth.database=portal" \
# --set "primary.podSecurityContext.fsGroup=$ID" \
# --set "primary.containerSecurityContext.runAsUser=$ID" \

# --set "dash.securityContext.fsGroup=$ID" \
# --set "dash.securityContext.runAsUser=$ID" \
# --set "gateway.securityContext.fsGroup=$ID" \
# --set "gateway.securityContext.runAsUser=$ID" \
# --set "pump.securityContext.fsGroup=$ID" \
# --set "pump.securityContext.runAsUser=$ID" \

# --set "enterprisePortal.securityContext.fsGroup=$ID" \
# --set "enterprisePortal.securityContext.runAsUser=$ID" \
