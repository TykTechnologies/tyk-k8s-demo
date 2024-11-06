## Elasticsearch—Kibana
Deploys the Elasticsearch deployment using the `bitnami/elasticsearch` chart
version `21.3.5` as well as a Kibana deployment using the `bitnami/kibana`
chart version `11.2.14` and creates a Kibana dashboard for you to view the
analytics.

### Example
```
./up.sh --deployments elasticsearch-kibana,k6-slo-traffic tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   | :white_check_mark: |
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
