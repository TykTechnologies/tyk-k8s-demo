postgresReleaseName="tyk-$1-postgres";
checkHelmReleaseExists $postgresReleaseName;

addService "$postgresReleaseName-postgresql";

if $releaseExists; then
  logger $INFO "$postgresReleaseName release already exists in $namespace namespace...skipping $postgresReleaseName install";
else
  set -x
  helm install $postgresReleaseName bitnami/postgresql --version 11.9.7 \
    -n $namespace \
    --set "auth.database=$1" \
    --set "auth.postgresPassword=$PASSWORD" \
    "${postgresSecurityContextArgs[@]}" \
    --wait
  set +x
fi
