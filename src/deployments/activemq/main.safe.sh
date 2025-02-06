if [ -z "$activeMQRegistered" ]; then
  activeMQRegistered=true;

  ACTIVEMQ_UI_PORT=8161;
  ACTIVEMQ_AMQP_PORT=25672;
  ACTIVEMQ_MQTT_PORT=21833;

  activeMQReleaseName="tyk-activemq";
  activeMQDeploymentPath="src/deployments/activemq";

  source "$activeMQDeploymentPath/checks.sh";
  source "$activeMQDeploymentPath/main.sh";
fi
