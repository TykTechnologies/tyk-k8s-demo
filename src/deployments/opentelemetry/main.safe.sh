if [ -z "$opentelemetryRegistered" ]; then
  opentelemetryRegistered=true;

  opentelemetrReleaseName="tyk-opentelemetry";
  opentelemetryDeploymentPath="src/deployments/opentelemetry";

  source "src/deployments/cert-manager/main.safe.sh";
  source "$opentelemetryDeploymentPath/main.sh";
fi
