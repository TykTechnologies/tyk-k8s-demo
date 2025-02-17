## Enterprise Developer Portal Deployment
Deploys the [Tyk Enterprise Developer Portal](https://tyk.io/docs/tyk-developer-portal/tyk-enterprise-developer-portal/)
using the `tyk-helm/tyk-dev-portal` chart version `1.0.0` as well as its
dependency PostgreSQL.

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
