logger "$INFO" "creating Tyk Operator Kafka example...";

setVerbose;
helm upgrade "$operatorKafkaReleaseName" bitnami/kafka --version 30.1.8 \
  --install \
  --namespace "$namespace" \
  --set "service.ports.client=$KAFKA_SERVICE_PORT" \
  --set "listeners.client.protocol=PLAINTEXT" \
  --set "controller.replicaCount=1" \
  --set "provisioning.topics[0]=test" \
  "${helmFlags[@]}" > /dev/null;

sed "s/replace_namespace/$namespace/g" "$operatorKafkaDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$operatorKafkaReleaseName/g" | \
  sed "s/replace_svc_port/$KAFKA_SERVICE_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;

addService "$operatorKafkaReleaseName";
