deploymentPath="src/deployments/operator-httpbin";

if ! $operatorHTTPBinRegistered; then
  operatorHTTPBinRegistered=true;
  source "$deploymentPath/main.sh";
fi

addService "httpbin-svc";
