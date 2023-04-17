## Prometheus Pump Deployment
This deployment do the following:
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
