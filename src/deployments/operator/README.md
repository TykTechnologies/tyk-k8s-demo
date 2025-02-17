## Tyk Operator
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator)
using the `tyk-helm/tyk-operator` chart version `0.18.0`and its dependency
[cert-manager](https://github.com/jetstack/cert-manager).

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator tyk-stack
```
