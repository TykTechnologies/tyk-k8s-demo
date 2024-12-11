if [ -z "$operatorKafkaRegistered" ]; then
  operatorKafkaRegistered=true;

  operatorKafkaDeploymentPath="src/deployments/operator-kafka";

  source "src/deployments/kafka/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorKafkaDeploymentPath/main.sh";
fi
