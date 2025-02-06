if [ -z "$operatoActiveMQMQTTaRegistered" ]; then
  operatorActiveMQMQTTRegistered=true;

  operatorActiveMQMQTTDeploymentPath="src/deployments/operator-activemq-mqtt";

  source "src/deployments/activemq/main.safe.sh";
  source "src/deployments/node-red/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorActiveMQMQTTDeploymentPath/main.sh";
fi
