if ! $operatorHTTPBinRegistered; then
  operatorHTTPBinRegistered=true;
  source "src/deployments/operator-httpbin/main.sh";
fi
