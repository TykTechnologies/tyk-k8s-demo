
if [ -z "$operatorHTTPBinRegistered" ]; then
  operatorHTTPBinRegistered=true;

  operatorHTTPDeploymentPath="src/deployments/operator-httpbin";

  source "src/deployments/operator/main.safe.sh";
  source "$operatorHTTPDeploymentPath/openshift.sh";
  source "$operatorHTTPDeploymentPath/main.sh";
fi
