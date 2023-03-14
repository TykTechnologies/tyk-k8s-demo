operatorReleaseName="tyk-operator";
certManagerReleaseName="tyk-operator-cert-manager";

if [ -z "$operatorRegistered" ]; then
  operatorRegistered=true;
  source "src/deployments/operator/main.sh";
fi
