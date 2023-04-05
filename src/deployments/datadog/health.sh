addService "datadog-agent-health-svc";

sed "s/replace_health_port/$DATADOG_AGENT_HEALTH_SERVICE_PORT/g" "$datadogDeploymentPath/health-svc-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
