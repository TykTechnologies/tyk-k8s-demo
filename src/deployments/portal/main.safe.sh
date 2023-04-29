portalDeploymentPath="src/deployments/portal";

if [ -z "$portalRegistered" ]; then
  portalRegistered=true;
  source "$portalDeploymentPath/checks.sh";
  source "$portalDeploymentPath/openshift.sh";
  source "$portalDeploymentPath/main.sh";
fi
