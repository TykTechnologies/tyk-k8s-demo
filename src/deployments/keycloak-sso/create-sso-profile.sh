auth=$(kubectl get secrets --namespace "$namespace" tyk-operator-conf -o jsonpath='{.data.TYK_AUTH}' | base64 -d);
port=$(kubectl get --namespace "$namespace" svc "dashboard-svc-$tykReleaseName-$chart" -o jsonpath='{.spec.ports[0].targetPort}');

logger "$DEBUG" "keycloak-sso/create-sso-profile.sh: creating sso profile";

sed "s/replace_auth/$auth/g" "$deploymentPath/create-sso-profile-template.yaml" | \
  sed "s/replace_org_id/$(kubectl get secrets --namespace "$namespace" tyk-operator-conf -o jsonpath='{.data.TYK_ORG}' | base64 -d)/g"  | \
  sed "s/replace_well_known_endpoint/https:\/\/$keycloakName-service.$namespace.svc:$KEYCLOAK_SERVICE_PORT\/realms\/keycloak-sso\/.well-known\/openid-configuration/g"  | \
  sed "s/replace_dashboard_url/dashboard-svc-$tykReleaseName-$chart.$namespace.svc:$port/g"  | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

