if [ -z "$resurfaceRegistered" ]; then
  resurfaceRegistered=true;

  RESURFACE_COORDINATOR_SERVICE_PORT=7700;
  RESURFACE_WORKER_SERVICE_PORT=7701;
  resurfaceReleaseName="resurface";
  resurfaceDeploymentPath="src/deployments/resurface";

  source "$resurfaceDeploymentPath/main.sh";
fi
