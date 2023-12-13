if [ -z "$elasticsearchRegistered" ]; then
  elasticsearchRegistered=true;

  ELASTICSEARCH_SERVICE_PORT=9200;
  elasticsearchReleaseName="elasticsearch";
  elasticsearchDeploymentPath="src/deployments/elasticsearch";

  source "$elasticsearchDeploymentPath/ssl.sh";
  source "$elasticsearchDeploymentPath/openshift.sh";
  source "$elasticsearchDeploymentPath/load-balancer.sh";
  source "$elasticsearchDeploymentPath/ingress.sh";
  source "$elasticsearchDeploymentPath/main.sh";
fi
