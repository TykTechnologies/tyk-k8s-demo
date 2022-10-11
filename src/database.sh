tykDatabaseArgs=()

if [ "postgres" == $database ]; then
  tykDB="database"
  source src/helpers/pgsql-exists.sh $tykDB
  source src/pgsql.sh $tykDB;
  tykDatabaseArgs=(--set "backend=postgres" \
    --set "postgres.host=tyk-$tykDB-postgres-postgresql.$namespace.svc.cluster.local" \
    --set "postgres.password=$PASSWORD" \
    --set "postgres.database=$tykDB" \
    --set "postgres.sslmode=disable")
else
  source src/mongo.sh;
  tykDatabaseArgs=(--set "mongo.mongoURL=mongodb://root:$PASSWORD@tyk-mongo-mongodb.$namespace.svc.cluster.local:27017/tyk_analytics?authSource=admin")
fi
