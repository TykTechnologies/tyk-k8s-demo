## Tyk Operator Streams ActiveMQ AMQP Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a HTTP to AMQP API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- activemq-http-to-amqp

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-streams-activemq-amqp tyk-stack
```

To consume:
```
curl http://localhost:8080/activemq-http-to-amqp/consume/stream
```
or
```
websocat ws://localhost:8080/activemq-http-to-amqp/consume/ws
```

To produce:
```
curl -X POST http://localhost:8080/activemq-http-to-amqp/produce -d 'Hello, Tyk!'
```

### Support
|     Item     | Status |
|:------------:|:------:|
|  OpenShift   |  :x:   |
|   CI Tests   |  :x:   |
| Postman Test |  :x:   |
|     SSL      |  N/A   |

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
