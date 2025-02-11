if [ -z "$operatorStreamsActiveMQMQTTaRegistered" ]; then
  operatorStreamsActiveMQMQTTRegistered=true;

  operatorStreamsActiveMQMQTTDeploymentPath="src/deployments/operator-streams-activemq-mqtt";

  source "src/deployments/activemq/main.safe.sh";
  source "src/deployments/node-red/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorStreamsActiveMQMQTTDeploymentPath/main.sh";
fi
