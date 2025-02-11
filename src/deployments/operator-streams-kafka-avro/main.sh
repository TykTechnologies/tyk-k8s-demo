logger "$INFO" "creating Tyk Operator Streams Kafka Avro to JSON example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorStreamsKafkaAvroDeploymentPath/kafka-producer-app.yaml" | \
  sed "s/replace_svc_name/$kafkaReleaseName.$namespace.svc/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  sed "s/replace_topic/avro/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

sed "s/replace_namespace/$namespace/g" "$operatorStreamsKafkaAvroDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$kafkaReleaseName.$namespace.svc/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  sed "s/replace_topic/avro/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
