if [ -z "$operatorStreamsRegistered" ]; then
  operatorStreamsRegistered=true;

  operatorStreamsDeploymentPath="src/deployments/operator-streams";

  source "src/deployments/operator/main.safe.sh";
  source "$operatorStreamsDeploymentPath/main.sh";
fi
