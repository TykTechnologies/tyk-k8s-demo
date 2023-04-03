logger "$INFO" "installing $grafanaReleaseName in $namespace namespace...";

addService "$grafanaReleaseName";

setVerbose;
kubectl apply -f src/deployments/prometheus-grafana/grafana-dashboards-configmap.yaml --namespace "$namespace" > /dev/null;
helm upgrade "$grafanaReleaseName" grafana/grafana \
  --install \
  --set "adminPassword=$PASSWORD" \
  --set "service.port=$GRAFANA_SERVICE_PORT" \
  --set "datasources.datasources\.yaml.apiVersion=1" \
  --set "datasources.datasources\.yaml.datasources[0].name=Prometheus" \
  --set "datasources.datasources\.yaml.datasources[0].type=prometheus" \
  --set "datasources.datasources\.yaml.datasources[0].url=http://$prometheusReleaseName-server:$PROMETHEUS_SERVICE_PORT" \
  --set "datasources.datasources\.yaml.datasources[0].access=proxy" \
  --set "datasources.datasources\.yaml.datasources[0].isDefault=true" \
  --set "dashboardProviders.dashboardproviders\.yaml.apiVersion=1" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].name=Tyk" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].orgId=1" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].type=file" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].disableDeletion=false" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].editable=true" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].updateIntervalSeconds=10" \
  --set "dashboardProviders.dashboardproviders\.yaml.providers[0].options.path=/etc/tyk-grafana/provisioning/dashboards" \
  --set "extraConfigmapMounts[0].name=grafana-dashboards" \
  --set "extraConfigmapMounts[0].mountPath=/etc/tyk-grafana/provisioning/dashboards/dashboards.json" \
  --set "extraConfigmapMounts[0].subPath=dashboards.json" \
  --set "extraConfigmapMounts[0].configMap=grafana-dashboards-configmap" \
  --set "extraConfigmapMounts[0].readOnly=true" \
  "${prometheusGrafanaSecurityContextArgs[@]}" \
  --namespace "$namespace" > /dev/null;
unsetVerbose;

addSummary "\tGrafana deployed\n \
\tUsername: admin\n \
\tPassword: $(kubectl get secret --namespace "$namespace" "$grafanaReleaseName" -o jsonpath="{.data.admin-password}" | base64 --decode)";
