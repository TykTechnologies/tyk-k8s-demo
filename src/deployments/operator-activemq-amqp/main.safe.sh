if [ -z "$operatoActiveMQAMQPRegistered" ]; then
  operatoActiveMQAMQPRegistered=true;

  operatorActiveMQAMQPDeploymentPath="src/deployments/operator-activemq-amqp";

  source "src/deployments/activemq/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorActiveMQAMQPDeploymentPath/main.sh";
fi
