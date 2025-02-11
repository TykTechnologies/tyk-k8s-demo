## ActiveMQ Artemis
This deployment will stand up ActiveMQ Artemis broker.

### Example
```
./up.sh --deployments activemq tyk-stack
```

### Support
|     Item     | Status |
|:------------:|:------:|
|  OpenShift   |  :x:   |
|   CI Tests   |  :x:   |
| Postman Test |  :x:   |
|     SSL      |  N/A   |

### Supported Service Types with `--expose` flag
|     Item      |       Status       |
|:-------------:|:------------------:|
| Port Forward  | :white_check_mark: |
|    Ingress    |        :x:         |
| Load Balancer |        :x:         |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
