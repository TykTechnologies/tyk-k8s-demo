## New Relic
Deploys New Relic using the `newrelic/nri-bundle` chart version `5.0.87`.
Stands up a Tyk pump to print analytics data to the Tyk pump STDOUT to allow
New Relic to scrape it.

### Requirements
The following options must be set in your `.env` file.
```
NEWRELIC_LICENSEKEY=7aaf3ae6bde1430ca8d83bebf5a1780fFFFFNRAL
NEWRELIC_CLUSTER=minikube
```

### Example
```
./up.sh --deployments newrelic,k6-slo-traffic tyk-stack
```
