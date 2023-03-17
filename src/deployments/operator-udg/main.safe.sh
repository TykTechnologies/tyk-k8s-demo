if [ -z "$operatorUDGRegistered" ]; then
  operatorUDGRegistered=true;
  source "src/deployments/operator/main.safe.sh";
  source "src/deployments/operator-udg/openshift.sh";
  source "src/deployments/operator-udg/main.sh";
fi
