if [ -z "$portalRegistered" ]; then
  portalRegistered=true;
  source "src/deployments/portal/main.sh";
fi
