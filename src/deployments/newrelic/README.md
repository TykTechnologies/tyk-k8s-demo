## New Relic
Deploys New Relic using the `newrelic/nri-bundle` chart version `5.0.87`.
Stands up a Tyk pump to print analytics data to the Tyk pump STDOUT to allow
New Relic to scrape it.

### Requirements
The following options must be set in your `.env` file.
```
NEWRELIC_LICENSEKEY=7aaf3ae6bde1430ca8d83bebf5a1780fFFFFNRAL
NEWRELIC_CLUSTER=minikube
```

### Example
```
./up.sh --deployments newrelic,k6-slo-traffic tyk-stack
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
