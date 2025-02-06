logger "$INFO" "creating Tyk Operator Mosquitto MQTT example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorMosquittoMQTTDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$mosquittoReleaseName.$namespace.svc/g" | \
  sed "s/replace_svc_port/$MOSQUITTO_SERVICE_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;
