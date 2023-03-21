if [ -z "$k6SLOTrafficRegistered" ]; then
  k6SLOTrafficRegistered=true;
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/k6/main.safe.sh";
  source "src/deployments/k6-slo-traffic/main.sh";
fi
