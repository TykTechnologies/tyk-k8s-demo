## OpenTelemetry
Deploys the OpenTelemetry collector using the `opentelemetry-collector` chart
version `0.108.1` and configures the Tyk deployment to send telemetry data to
Grafana Tempo through the OpenTelemetry collector.

### Example
```
./up.sh --deployments opentelemetry tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |     :warning:      |
|   CI Tests   | :white_check_mark: |
| Postman Test |        :x:         |
|     SSL      |        N/A         |

### Supported Service Types with `--expose` flag
|     Item      | Status |
|:-------------:|:------:|
| Port Forward  |  N/A   |
|    Ingress    |  N/A   |
| Load Balancer |  N/A   |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
