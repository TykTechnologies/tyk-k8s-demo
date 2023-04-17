if [ -z "$operatorHTTPBinRegistered" ]; then
  operatorHTTPBinRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "src/deployments/operator-httpbin/openshift.sh";
  source "src/deployments/operator-httpbin/main.sh";
fi
