if [ -z "$operatorStreamsKafkaRegistered" ]; then
  operatorStreamsKafkaRegistered=true;

  operatorStreamsKafkaDeploymentPath="src/deployments/operator-streams-kafka";

  source "src/deployments/kafka/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorStreamsKafkaDeploymentPath/main.sh";
fi
