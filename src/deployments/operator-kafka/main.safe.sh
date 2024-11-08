if [ -z "$operatorKafkaRegistered" ]; then
  operatorKafkaRegistered=true;

  KAFKA_SERVICE_PORT=9092;

  operatorKafkaReleaseName="tyk-kafka";
  operatorKafkaDeploymentPath="src/deployments/operator-kafka";

  source "src/deployments/operator/main.safe.sh";
  source "$operatorKafkaDeploymentPath/main.sh";
fi
