## Tyk Operator GraphQL Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a Federation v1 API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- TrevorBlades Countries example

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-graphql tyk-stack
```
