logger "$INFO" "creating Tyk Operator Kafka Avro to JSON example...";

addDeploymentArgs "${args[@]}";
upgradeTyk;

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorKafkaAvroDeploymentPath/kafka-producer-app.yaml" | \
  sed "s/replace_svc_name/$kafkaReleaseName.$namespace.svc/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  sed "s/replace_topic/avro/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

sed "s/replace_namespace/$namespace/g" "$operatorKafkaAvroDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$kafkaReleaseName.$namespace.svc/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  sed "s/replace_topic/avro/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
