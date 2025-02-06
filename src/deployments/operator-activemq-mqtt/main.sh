logger "$INFO" "creating Tyk Operator ActiveMQ MQTT example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorActiveMQMQTTDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$activeMQReleaseName-mqtt-svc.$namespace.svc/g" | \
  sed "s/replace_svc_port/$ACTIVEMQ_MQTT_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
