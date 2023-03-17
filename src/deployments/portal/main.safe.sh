if [ -z "$portalRegistered" ]; then
  portalRegistered=true;
  source "src/deployments/portal/checks.sh";
  source "src/deployments/portal/openshift.sh";
  source "src/deployments/portal/main.sh";
fi
