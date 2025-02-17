## Elasticsearch—Kibana
Deploys the Elasticsearch deployment using the `bitnami/elasticsearch` chart
version `21.3.5` as well as a Kibana deployment using the `bitnami/kibana`
chart version `11.2.14` and creates a Kibana dashboard for you to view the
analytics.

### Example
```
./up.sh --deployments elasticsearch-kibana,k6-slo-traffic tyk-stack
```
