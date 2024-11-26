logger "$INFO" "creating Tyk Operator Kafka example...";

addDeploymentArgs "${args[@]}";
upgradeTyk;

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorKafkaDeploymentPath/kafka-producer-app.yaml" | \
  sed "s/replace_svc_name/$kafkaReleaseName/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;

sed "s/replace_namespace/$namespace/g" "$operatorKafkaDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$kafkaReleaseName/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
