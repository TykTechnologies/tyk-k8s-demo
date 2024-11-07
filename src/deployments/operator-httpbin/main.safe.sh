if [ -z "$operatorHTTPBinRegistered" ]; then
  operatorHTTPBinRegistered=true;

  operatorHTTPBinDeploymentPath="src/deployments/operator-httpbin";

  source "src/deployments/operator/main.safe.sh";
  source "$operatorHTTPBinDeploymentPath/openshift.sh";
  source "$operatorHTTPBinDeploymentPath/main.sh";
fi
