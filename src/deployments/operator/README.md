## Operator Deployment
Operator deployment will install the [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency [cert-manager](https://github.com/jetstack/cert-manager).

#### cert-manager
This deployment installs `cert-manager` into the `cert-manager` namespace.

Command run to install `cert-manager`:
`kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.8.0/cert-manager.yaml`

#### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
minikube addons enable ingress-dns
minikube start
```
