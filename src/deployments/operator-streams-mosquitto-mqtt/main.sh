logger "$INFO" "creating Tyk Operator Streams Mosquitto MQTT example...";

setVerbose;
sed "s/replace_namespace/$namespace/g" "$operatorStreamsMosquittoMQTTDeploymentPath/api-template.yaml" | \
  sed "s/replace_svc_name/$mosquittoReleaseName.$namespace.svc/g" | \
  sed "s/replace_svc_port/$MOSQUITTO_SERVICE_PORT/g" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
unsetVerbose;

args=(
  --set "tyk-gateway.gateway.image.repository=tykio/tyk-gateway-ee" \
);
addDeploymentArgs "${args[@]}";
