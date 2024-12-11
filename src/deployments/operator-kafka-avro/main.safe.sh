if [ -z "$operatorKafkaAvroRegistered" ]; then
  operatorKafkaAvroRegistered=true;

  operatorKafkaAvroDeploymentPath="src/deployments/operator-kafka-avro";

  source "src/deployments/kafka/main.safe.sh";
  source "src/deployments/operator/main.safe.sh";
  source "$operatorKafkaAvroDeploymentPath/main.sh";
fi
