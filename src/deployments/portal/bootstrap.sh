set +e;
search=$(kubectl get secret --namespace "$namespace" | awk '{print $1}' | grep -e "^portal-bootstrap-secrets");
logger "$DEBUG" "namespace-exists: search result: $search";
set -e;

if [[ -z $search ]]; then
  logger "$INFO" "bootstrapping portal...";
  # Get pod and JWT
  pod=$(kubectl get pods --namespace "$namespace" -l "app=$tykReleaseName-tyk-dev-portal" -o jsonpath='{.items[*].metadata.name}');
  jwt=$(kubectl logs --namespace "$namespace" "$pod" | awk -F'Generated JWToken: ' '{print substr($2, 1, length($2)-2)}' | tr -d '[:space:]');

  # Create secret
  kubectl create secret generic "portal-bootstrap-secrets" --namespace "$namespace" \
    --from-literal="PORTAL_API_KEY=$jwt" \
    --from-literal="DASHBOARD_API_KEY=$(kubectl get secrets -n tyk tyk-operator-conf -o=jsonpath="{.data.TYK_AUTH}" | base64 -d)" \
    > /dev/null;

  # Create bootstrap script configmap
  sed "s/replace_url/$protocol:\/\/dev-portal-svc-$tykReleaseName-tyk-dev-portal:$PORTAL_SERVICE_PORT/g" "$portalDeploymentPath/bootstrap-configmap-template.yaml" | \
    sed "s/replace_dashboard_url/$protocol:\/\/dashboard-svc-$tykReleaseName-tyk-dashboard:3000/g" | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;

  # Run bootstrap job
  kubectl apply --namespace "$namespace" -f "$portalDeploymentPath/bootstrap-job.yaml" > /dev/null;
fi
