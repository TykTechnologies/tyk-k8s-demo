KIBANA_SERVICE_PORT=5601;
elasticsearchKibanaReleaseName="elasticsearch-kibana";

if [ -z "$elasticsearchKibanaRegistered" ]; then
  elasticsearchKibanaRegistered=true;
  source "src/deployments/elasticsearch/main.safe.sh";
  source "src/deployments/elasticsearch-kibana/main.sh";
fi
