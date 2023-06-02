PORTAL_SERVICE_PORT=3001;
portalDeploymentPath="src/deployments/portal";

if [ -z "$portalRegistered" ]; then
  portalRegistered=true;
  source "src/deployments/operator-httpbin/main.safe.sh"
  source "$portalDeploymentPath/checks.sh";
  source "$portalDeploymentPath/openshift.sh";
  source "$portalDeploymentPath/main.sh";
fi
