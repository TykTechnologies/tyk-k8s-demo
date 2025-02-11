logger "$INFO" "creating Tyk Operator Streams ActiveMQ AMQP example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorStreamsActiveMQAMQPDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$activeMQReleaseName-amqp-svc.$namespace.svc/g" | \
  sed "s/replace_svc_port/$ACTIVEMQ_AMQP_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
