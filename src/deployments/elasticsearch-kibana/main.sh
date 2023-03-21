logger "$INFO" "installing $elasticsearchKibanaReleaseName in $namespace namespace...";

addService "$elasticsearchKibanaReleaseName";

setVerbose;
helm upgrade "$elasticsearchKibanaReleaseName" bitnami/kibana \
  --install \
  --set "elasticsearch.hosts[0]=$elasticsearchReleaseName.$namespace.svc" \
  --set "elasticsearch.port=$ELASTICSEARCH_SERVICE_PORT" \
  --set "service.ports.http=$KIBANA_SERVICE_PORT" \
  --namespace "$namespace" \
  --wait > /dev/null;
unsetVerbose;
