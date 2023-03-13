deploymentsPath="src/deployments";
deploymentPath="src/deployments/k6-traffic-sim";

if ! $k6TrafficSimRegistered; then
  k6TrafficSimRegistered=true;
  source "src/deployments/k6-traffic-sim/main.sh";
fi
