addService "keycloak-health-svc";

sed "s/replace_health_port/$KEYCLOAK_MANAGEMENT_PORT/g" "$keycloakDeploymentPath/health-svc-template.yaml" | \
  kubectl apply -n "$namespace" -f - > /dev/null;
