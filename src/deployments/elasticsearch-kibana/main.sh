logger "$INFO" "installing $elasticsearchKibanaReleaseName in $namespace namespace...";

addService "$elasticsearchKibanaReleaseName";

setVerbose;
helm upgrade "$elasticsearchKibanaReleaseName" bitnami/kibana --version 11.2.14 \
  --install \
  --set "elasticsearch.hosts[0]=$elasticsearchReleaseName.$namespace.svc" \
  --set "elasticsearch.port=$ELASTICSEARCH_SERVICE_PORT" \
  --set "service.ports.http=$KIBANA_SERVICE_PORT" \
  --set "resourcesPreset=micro" \
  "${elasticsearchKibanaSecurityContextArgs[@]}" \
  "${elasticsearchKibanaSSLArgs[@]}" \
  "${elasticsearchKibanaLoadbalancerArgs[@]}" \
  "${elasticsearchKibanaIngressArgs[@]}" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

logger "$DEBUG" "elasticsearch-kibana: adding tyk-analytics data view to kibana...";
kibana_pod=$(kubectl get pods -l app=kibana --namespace "$namespace" -o jsonpath='{.items[0].metadata.name}');
result=$(kubectl exec "$kibana_pod" --namespace "$namespace" -- curl -s --insecure -X POST $protocol://localhost:5601/api/data_views/data_view \
  -u "elastic:$TYK_PASSWORD" \
  -H "kbn-xsrf: true" \
  -H "Content-Type: application/json" \
  -d "$(cat "$elasticsearchKibanaDeploymentPath/tyk_analytics-data-view.json")");
logger "$DEBUG" "elasticsearch-kibana: result: $result";
