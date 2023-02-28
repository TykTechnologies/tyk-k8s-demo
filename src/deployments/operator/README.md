## Operator Deployment
Operator deployment will install the [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency [cert-manager](https://github.com/jetstack/cert-manager).

#### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```
