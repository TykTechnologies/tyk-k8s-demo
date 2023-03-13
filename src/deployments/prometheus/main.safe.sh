prometheusReleaseName="tyk-prometheus";
grafanaReleaseName="tyk-grafana";

if ! $prometheusRegistered; then
  prometheusRegistered=true;
  source "src/deployments/prometheus/main.sh";
fi

addService "pump-svc-$tykReleaseName";
addService "$prometheusReleaseName-server";
addService "$grafanaReleaseName";
