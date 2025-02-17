if [ -z "$rabbitMQRegistered" ]; then
  rabbitMQRegistered=true;

  RABBITMQ_PORT=35672;

  rabbitMQReleaseName="tyk-rabbitmq";
  rabbitMQDeploymentPath="src/deployments/rabbitmq";

  source "src/deployments/operator/main.safe.sh";
  source "$rabbitMQDeploymentPath/checks.sh";
  source "$rabbitMQDeploymentPath/main.sh";
fi
