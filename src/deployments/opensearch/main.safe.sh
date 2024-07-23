if [ -z "$opensearchRegistered" ]; then
  opensearchRegistered=true;

  OPENSEARCH_SERVICE_PORT=9201;
  OPENSEARCH_DASHBOARD_SERVICE_PORT=5602;
  opensearchReleaseName="opensearch";
  opensearchDeploymentPath="src/deployments/opensearch";

  source "$opensearchDeploymentPath/ssl.sh";
  source "$opensearchDeploymentPath/openshift.sh";
  source "$opensearchDeploymentPath/load-balancer.sh";
  source "$opensearchDeploymentPath/ingress.sh";
  source "$opensearchDeploymentPath/main.sh";
fi
