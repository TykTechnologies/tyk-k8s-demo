## K6 SLO Traffic
Deploys a k6 CRD to generate a load of traffic to seed analytics data.

### Example
```
./up.sh --deployments k6-slo-traffic tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |        N/A         |
|   CI Tests   | :white_check_mark: |
| Postman Test |        N/A         |
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
