RESURFACE_COORDINATOR_SERVICE_PORT=7700;
RESURFACE_WORKER_SERVICE_PORT=7701;
resurfaceReleaseName="resurface";
resurfaceDeploymentPath="src/deployments/resurface";

if [ -z "$resurfaceRegistered" ]; then
  resurfaceRegistered=true;
  source "$resurfaceDeploymentPath/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
