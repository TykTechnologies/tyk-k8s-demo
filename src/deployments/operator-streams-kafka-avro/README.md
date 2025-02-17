## Tyk Operator Streams Kafka Avro Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a Kafka AVRO to JSON API
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
./up.sh --deployments operator-streams-kafka-avro tyk-stack
```

To consume topic:
```
curl http://localhost:8080/avro-to-json/consume
```
