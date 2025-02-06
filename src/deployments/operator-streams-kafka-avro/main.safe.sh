if [ -z "$operatorStreamsKafkaAvroRegistered" ]; then
  operatorStreamsKafkaAvroRegistered=true;

  operatorStreamsKafkaAvroDeploymentPath="src/deployments/operator-streams-kafka-avro";

  source "src/deployments/kafka/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorStreamsKafkaAvroDeploymentPath/main.sh";
fi
