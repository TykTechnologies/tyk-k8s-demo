if [ -z "$operatoMQTTaRegistered" ]; then
  operatorMQTTRegistered=true;

  operatorMQTTDeploymentPath="src/deployments/operator-mqtt";

  source "src/deployments/mosquitto/main.safe.sh";
  source "src/deployments/node-red/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorMQTTDeploymentPath/main.sh";
fi
