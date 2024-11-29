## Tyk Operator Kafka Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a Federation v1 API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- avro-to-json

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-kafka-avro tyk-stack
```

To consume topic:
```
curl http://localhost:8080/avro-to-json/consume
```

### Support
|     Item     |  Status   |
|:------------:|:---------:|
|  OpenShift   | :warning: |
|   CI Tests   |    :x:    |
| Postman Test |    :x:    |
|     SSL      |    N/A    |

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
