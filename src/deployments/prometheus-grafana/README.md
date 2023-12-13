## Grafana-Prometheus
Deploys the Prometheus deployment using the `bitnami/elasticsearch` chart
version `25.3.0` as well as a Grafana deployment using the `grafana/grafana`
chart version `6.52.7` and creates a Grafana dashboard for you to view the
analytics.

### Example
```
./up.sh --deployments prometheus-grafana tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |     :warning:      |
|     ARM      | :white_check_mark: |
|   CI Tests   | :white_check_mark: |
| Postman Test | :white_check_mark: |
|     SSL      |     :no_entry:     |

### Supported Service Types with `--expose` flag
|     Item      |       Status       |
|:-------------:|:------------------:|
| Port Forward  | :white_check_mark: |
|    Ingress    | :white_check_mark: |
| Load Balancer | :white_check_mark: |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
