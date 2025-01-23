if [ -z "$portalRegistered" ]; then
  portalRegistered=true;

  PORTAL_SERVICE_PORT=3001;
  portalDeploymentPath="src/deployments/portal";

  source "src/deployments/operator-httpbin/main.safe.sh"
  source "$portalDeploymentPath/checks.sh";
  source "$portalDeploymentPath/ssl.sh";
  source "$portalDeploymentPath/openshift.sh";
  source "$portalDeploymentPath/load-balancer.sh";
  source "$portalDeploymentPath/ingress.sh";
  source "$portalDeploymentPath/main.sh";
fi
