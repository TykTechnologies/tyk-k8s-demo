## Tyk Operator Federation Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a Federation v1 API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- Social Media App - Federated
- users-subgraph
- posts-subgraph
- comments-subgraph
- notifications-subgraph

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-federation tyk-stack
```
