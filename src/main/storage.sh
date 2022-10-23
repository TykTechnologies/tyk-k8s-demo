tykStorageArgs=();

if [[ $POSTGRES == $storage ]]; then
  tykDBName="storage";
  tykDBPort=5432;
  source src/main/pgsql.sh $tykDBName $tykDBPort;
  tykStorageArgs=(--set "backend=postgres" \
    --set "postgres.host=tyk-$tykDBName-postgres-postgresql.$namespace.svc.cluster.local" \
    --set "postgres.port=$tykDBPort" \
    --set "postgres.password=$PASSWORD" \
    --set "postgres.database=$tykDBName" \
    --set "postgres.sslmode=disable");
else
  source src/main/mongo.sh;
  tykStorageArgs=(--set "mongo.mongoURL=mongodb://root:$PASSWORD@tyk-mongo-mongodb.$namespace.svc.cluster.local:27017/tyk_analytics?authSource=admin");
fi
