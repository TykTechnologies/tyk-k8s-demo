if [ -z "$operatorStreamsMosquittoMQTTaRegistered" ]; then
  operatorStreamsMosquittoMQTTRegistered=true;

  operatorStreamsMosquittoMQTTDeploymentPath="src/deployments/operator-streams-mosquitto-mqtt";

  source "src/deployments/mosquitto/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorStreamsMosquittoMQTTDeploymentPath/main.sh";
fi
