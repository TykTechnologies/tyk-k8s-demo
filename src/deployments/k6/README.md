## K6 Operator
Deploys a Grafana K6 Operator using the `grafana/k6-operator` chart version
`1.2.0`.

### Example
```
./up.sh --deployments k6 tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   | :white_check_mark: |
|     ARM      | :white_check_mark: |
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
