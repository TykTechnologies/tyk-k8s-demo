## Jaeger
Deploys the Jaeger operator using the `jaegertracing/jaeger-operator` chart
version `v2.46.2`, a Jaeger instance using the Jaeger `jaegertracing.io/v1`
CRD, and the OpenTelemetry collector using the
`open-telemetryopentelemetry-collector` chart version `0.62.0` and configures
the Tyk deployment to send telemetry data to Jaeger through the OpenTelemetry
collector.

### Example
```
./up.sh --deployments jaeger tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |        :x:         |
|     ARM      | :white_check_mark: |
|   CI Tests   | :white_check_mark: |
| Postman Test | :white_check_mark: |
|     SSL      |     :no_entry:     |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |