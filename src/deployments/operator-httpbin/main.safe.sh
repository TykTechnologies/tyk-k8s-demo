operatorHTTPDeploymentPath="src/deployments/operator-httpbin";

if [ -z "$operatorHTTPBinRegistered" ]; then
  operatorHTTPBinRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "$operatorHTTPDeploymentPath/openshift.sh";
  source "$operatorHTTPDeploymentPath/main.sh";
fi
