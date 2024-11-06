if [ -z "$tempoRegistered" ]; then
  tempoRegistered=true;

  tempoReleaseName="tyk-tempo";
  tempoDeploymentPath="src/deployments/tempo";

  source "src/deployments/opentelemetry/main.safe.sh";
  source "src/deployments/prometheus-grafana/main.safe.sh";
  source "$tempoDeploymentPath/main.sh";
fi
