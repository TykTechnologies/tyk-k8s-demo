deploymentPath="src/deployments/keycloak-sso";
crName="tyk-sso";

logger "$INFO" "installing keycloak SSO realm in $namespace namespace...";

sed "s/replace_cr_name/$crName/g" "$deploymentPath/realm-template.yaml" | \
sed "s/replace_keycloak/$keycloakName/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

if [ "$(kubectl get pods -l "job-name=$crName" --namespace "$namespace" -o json | jq '.status.phase')" != "Succeeded" ]; then
  logger "$DEBUG" "keycloak-sso: waiting for $crName to be created";
  waitForPods "job-name=$crName" "$crName";
  kubectl wait --namespace "$namespace" jobs "$crName" --for=condition=complete --timeout=120s > /dev/null;

  logger "$INFO" "waiting for keycloak to be ready...";
  kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=condition=Ready --timeout=180s > /dev/null;

  source "$deploymentPath/create-sso-profile.sh";
fi
