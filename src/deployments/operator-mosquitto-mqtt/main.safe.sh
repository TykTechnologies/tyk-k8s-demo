if [ -z "$operatoMosquittoMQTTaRegistered" ]; then
  operatorMosquittoMQTTRegistered=true;

  operatorMosquittoMQTTDeploymentPath="src/deployments/operator-mosquitto-mqtt";

  source "src/deployments/mosquitto/main.safe.sh";
  source "src/deployments/node-red/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorMosquittoMQTTDeploymentPath/main.sh";
fi
