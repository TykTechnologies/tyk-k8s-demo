logger "$INFO" "installing tyk-elasticsearch...";

addService "$elasticsearchReleaseName";

setVerbose;
helm upgrade "$elasticsearchReleaseName" bitnami/elasticsearch \
  --install \
  --set "global.elasticsearch.service.ports.restAPI=$ELASTICSEARCH_SERVICE_PORT" \
  --namespace "$namespace" \
  --wait > /dev/null;
unsetVerbose;

logger "$INFO" "installed tyk-elasticsearch in namespace $namespace";
