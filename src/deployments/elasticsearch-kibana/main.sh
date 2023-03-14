logger "$INFO" "installing tyk-elasticsearch-kibana...";

addService "$elasticsearchKibanaReleaseName";

setVerbose;
helm upgrade "$elasticsearchKibanaReleaseName" bitnami/kibana \
  --install \
  --set "elasticsearch.hosts[0]=$elasticsearchKibanaReleaseName.$namespace.svc" \
  --set "elasticsearch.port=$ELASTICSEARCH_SERVICE_PORT" \
  --set "service.ports.http=$KIBANA_SERVICE_PORT" \
  --namespace "$namespace" \
  --wait > /dev/null;
unsetVerbose;

logger "$INFO" "installed tyk-elasticsearch-kibana in namespace $namespace";
