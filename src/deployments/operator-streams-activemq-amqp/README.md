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
