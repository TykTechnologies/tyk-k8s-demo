## OpenTelemetry
Deploys the OpenTelemetry collector using the `opentelemetry-collector` chart
version `0.108.1` and configures the Tyk deployment to send telemetry data to
Grafana Tempo through the OpenTelemetry collector.

### Example
```
./up.sh --deployments opentelemetry tyk-stack
```
