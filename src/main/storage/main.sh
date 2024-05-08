if [[ $POSTGRES == "$storage" ]]; then
  tykDBName="storage";
  tykDBPort=5432;
  source src/main/storage/pgsql.sh $tykDBName $tykDBPort;
  logger "$DEBUG" "storage/main.sh: setting tyk related postgres configuration";
    args=(
    --set "global.storageType=postgres" \
    --set "global.postgres.host=tyk-$tykDBName-postgres-postgresql.$namespace.svc" \
    --set "global.postgres.port=$tykDBPort" \
    --set "global.postgres.password=$TYK_PASSWORD" \
    --set "global.postgres.database=$tykDBName" \
    --set "global.postgres.sslmode=disable"\
    --set "tyk-pump.pump.backend[$pumpBackendsCtr]=postgres" \
  );
else
  source src/main/storage/mongo.sh;
  logger "$DEBUG" "storage/main.sh: setting tyk related mongo configuration";
  args=(
    --set "global.storageType=mongo" \
    --set "global.mongo.mongoURL=mongodb://root:$TYK_PASSWORD@tyk-mongo-mongodb.$namespace.svc:27017/tyk_analytics?authSource=admin" \
    --set "tyk-pump.pump.backend[$pumpBackendsCtr]=mongo" \
  );
fi

pumpBackendsCtr=$((pumpBackendsCtr + 1));

addDeploymentArgs "${args[@]}";
