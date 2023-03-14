if [ -z "$k6TrafficSimRegistered" ]; then
  k6TrafficSimRegistered=true;
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/k6-traffic-sim/main.sh";
fi
