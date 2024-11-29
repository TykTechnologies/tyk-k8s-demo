logger "$INFO" "installing $kafkaReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$kafkaReleaseName" bitnami/kafka --version 30.1.8 \
  --install \
  --namespace "$namespace" \
  --set "service.ports.client=$KAFKA_SERVICE_PORT" \
  --set "listeners.client.protocol=PLAINTEXT" \
  --set "controller.replicaCount=3" \
  --set "provisioning.topics[0]=test" \
  --set "provisioning.topics[0]=avro" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

addService "$kafkaReleaseName";
