logger "$INFO" "creating Tyk Operator Streams Kafka example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorStreamsKafkaDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$kafkaReleaseName.$namespace.svc/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;

args=(
  --set "tyk-gateway.gateway.image.repository=tykio/tyk-gateway-ee" \
);
addDeploymentArgs "${args[@]}";
