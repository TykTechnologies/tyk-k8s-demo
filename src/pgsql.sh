if $pgsqlExists; then
  echo "Warning: tyk-$1-postgres release already exists...skipping Postgres install."
else
  set -x
  helm install tyk-$1-postgres bitnami/postgresql --version 11.9.7 \
    -n $namespace \
    --set "auth.database=$1" \
    --set "auth.postgresPassword=$PASSWORD" \
    "${postgresSecurityContextArgs[@]}" \
    --wait
  set +x
fi
