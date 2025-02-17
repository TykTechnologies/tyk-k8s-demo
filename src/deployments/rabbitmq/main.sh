logger "$INFO" "installing $rabbitMQReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$rabbitMQReleaseName" bitnami/rabbitmq --version 15.3.1 \
  --install \
  --set "service.ports.amqp=$RABBITMQ_PORT" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

addService "$rabbitMQReleaseName";
