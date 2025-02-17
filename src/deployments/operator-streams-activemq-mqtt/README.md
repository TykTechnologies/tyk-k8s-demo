## Tyk Operator Streams ActiveMQ MQTT Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a HTTP to MQTT API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- activemq-http-to-mqtt

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-streams-activemq-mqtt tyk-stack
```

To consume:
```
curl http://localhost:8080/activemq-http-to-mqtt/consume/stream
```
or
```
websocat ws://localhost:8080/activemq-http-to-mqtt/consume/ws
```

To produce:
```
curl -X POST http://localhost:8080/activemq-http-to-mqtt/produce -d 'Hello, Tyk!'
```
