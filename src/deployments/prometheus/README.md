## Prometheus Pump Deployment
Deploys Prometheus using the `prometheus-community/prometheus` chart version `25.24.1`
and stands up a Tyk pump to push analytics data from the Tyk platform to
Prometheus.

This deployment will do the following:
- Create a Prometheus with Tyk Pump with custom metrics
- Create a Tyk Pump service
- Deploy a Prometheus instance with custom rules and jobs

#### Prometheus Pump Custom Metrics
```json
"custom_metrics":[
  {
    "name":"tyk_http_requests_total",
    "description":"Total of API requests",
    "metric_type":"counter",
    "labels":["response_code","api_name","method","api_key","alias","path"]
  },
  {
    "name":"tyk_http_latency",
    "description":"Latency of API requests",
    "metric_type":"histogram",
    "labels":["type","response_code","api_name","method","api_key","alias","path"]
  }
]
```

### Example
```
./up.sh --deployments prometheus tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |     :no_entry:     |
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
