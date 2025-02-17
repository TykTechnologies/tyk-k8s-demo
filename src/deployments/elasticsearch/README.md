## Elasticsearch
Deploys Elasticsearch using the `bitnami/elasticsearch` chart version `21.3.5`.
Stands up a Tyk pump to push analytics data from the Tyk platform to Elasticsearch.

### Example
```
./up.sh --deployments elasticsearch,k6-slo-traffic tyk-stack
```
