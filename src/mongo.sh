set -x
helm install tyk-mongo bitnami/mongodb --version 11.1.10 \
  -n $namespace \
  --set "auth.rootPassword=$PASSWORD" \
  --set "replicaSet.enabled=true" \
  "${mongoSecurityContextArgs[@]}" \
  --wait
set +x
