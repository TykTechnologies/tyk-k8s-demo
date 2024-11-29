if [ -z "$kafkaRegistered" ]; then
  kafkaRegistered=true;

  KAFKA_SERVICE_PORT=9092;

  kafkaReleaseName="tyk-kafka";
  kafkaDeploymentPath="src/deployments/kafka";

  source "$kafkaDeploymentPath/checks.sh";
  source "$kafkaDeploymentPath/main.sh";
fi
