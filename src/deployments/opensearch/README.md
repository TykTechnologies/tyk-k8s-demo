## Opensearch
Deploys Opensearch using the `bitnami/opensearch` chart version `1.2.8`.
Stands up a Tyk pump to push analytics data from the Tyk platform to Opensearch.

### Example
```
./up.sh --deployments opensearch,k6-slo-traffic tyk-stack
```
