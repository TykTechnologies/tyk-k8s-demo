if [ -z "$operatorStreamsActiveMQAMQPRegistered" ]; then
  operatorStreamsActiveMQAMQPRegistered=true;

  operatorStreamsActiveMQAMQPDeploymentPath="src/deployments/operator-streams-activemq-amqp";

  source "src/deployments/activemq/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorStreamsActiveMQAMQPDeploymentPath/main.sh";
fi
