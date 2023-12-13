## Elasticsearch
Deploys Elasticsearch using the `bitnami/elasticsearch` chart version `19.13.1`.
Stands up a Tyk pump to push analytics data from the Tyk platform to Elasticsearch.

### Example
```
./up.sh --deployments elasticsearch,k6-slo-traffic tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   | :white_check_mark: |
|     ARM      | :white_check_mark: |
|   CI Tests   | :white_check_mark: |
| Postman Test | :white_check_mark: |
|     SSL      | :white_check_mark: |

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
