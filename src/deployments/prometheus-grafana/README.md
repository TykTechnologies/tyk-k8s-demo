## Grafana-Prometheus
Deploys Prometheus using the `prometheus-community/prometheus` chart
version `25.24.1` as well as a Grafana deployment using the `grafana/grafana`
chart version `8.3.6` and creates a Grafana dashboard for you to view the
analytics.

### Example
```
./up.sh --deployments prometheus-grafana tyk-stack
```
