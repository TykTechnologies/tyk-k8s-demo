tykDatabaseArgs=()

if [ $database == "mongo" ]; then
  source src/mongo.sh;
  tykDatabaseArgs=(--set "mongo.mongoURL=mongodb://root:topsecretpassword@tyk-mongo-mongodb.$namespace.svc.cluster.local:27017/tyk_analytics?authSource=admin")
else
  tykDB="database"
  source src/pgsql.sh $tykDB;
  tykDatabaseArgs=(--set "backend=postgres" \
    --set "postgres.host=tyk-$tykDB-postgres-postgresql.$namespace.svc.cluster.local" \
    --set "postgres.password=topsecretpassword" \
    --set "postgres.database=$tykDB" \
    --set "postgres.sslmode=disable")
fi
