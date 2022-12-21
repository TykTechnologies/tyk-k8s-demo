if [[ $POSTGRES == "$storage" ]]; then
  tykDBName="storage";
  tykDBPort=5432;
  source src/main/pgsql.sh $tykDBName $tykDBPort;
  args=(--set "backend=postgres" \
    --set "postgres.host=tyk-$tykDBName-postgres-postgresql.$namespace.svc" \
    --set "postgres.port=$tykDBPort" \
    --set "postgres.password=$PASSWORD" \
    --set "postgres.database=$tykDBName" \
    --set "postgres.sslmode=disable");
else
  source src/main/mongo.sh;
  args=(--set "mongo.mongoURL=mongodb://root:$PASSWORD@tyk-mongo-mongodb.$namespace.svc:27017/tyk_analytics?authSource=admin");
fi

addDeploymentArgs "${args[@]}";
