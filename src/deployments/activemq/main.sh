logger "$INFO" "installing $activeMQReleaseName in $namespace namespace...";

setVerbose;
sed "s/replace_amqp_port/$ACTIVEMQ_AMQP_PORT/g" "$activeMQDeploymentPath/activemq-artemis-app-template.yaml" | \
  sed "s/replace_mqtt_port/$ACTIVEMQ_MQTT_PORT/g" | \
  sed "s/replace_ui_port/$ACTIVEMQ_UI_PORT/g" | \
  sed "s/replace_name/$activeMQReleaseName/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;
unsetVerbose;

addService "$activeMQReleaseName-amqp-svc";
addService "$activeMQReleaseName-mqtt-svc";
addService "$activeMQReleaseName-ui-svc";
