source src/helpers/mongo-exists.sh

if $mongoExists; then
  echo "Warning: tyk-mongo release already exists...skipping Mongo install."
else
  set -x
  helm install tyk-mongo bitnami/mongodb --version 11.1.10 \
    -n $namespace \
    --set "auth.rootPassword=$PASSWORD" \
    --set "replicaSet.enabled=true" \
    "${mongoSecurityContextArgs[@]}" \
    --wait
  set +x
fi
