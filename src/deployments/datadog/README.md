## DataDog
Deploys Datadog agent using the `datadog/datadog` chart version `3.25.1`.
Stands up a Tyk pump to push analytics data from the Tyk platform to Datadog.
It will also create a Datadog dashboard for you to view the analytics.

### Requirements
The following options must be set in your `.env` file.
```
DATADOG_APIKEY=59937fe2b222e4fbbd56106e4f9da331
DATADOG_APPKEY=85e5ffd803b0b11acb1ddc420431c5aeac815734
DATADOG_SITE=datadoghq.com
```

### Example
```
./up.sh --deployments datadog,k6-slo-traffic tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   | :white_check_mark: |
|     ARM      | :white_check_mark: |
|   CI Tests   | :white_check_mark: |
| Postman Test | :white_check_mark: |
|     SSL      |        N/A         |

### Supported Service Types with `--expose` flag
|     Item      |       Status       |
|:-------------:|:------------------:|
| Port Forward  | :white_check_mark: |
|    Ingress    |        N/A         |
| Load Balancer |        N/A         |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
