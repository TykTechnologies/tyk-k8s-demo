## Tyk Operator Universal Data Graph (UDG) Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a UDG API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- Social Media App - REST to GQL Stitching using UDG
	- users-rest
	- posts-rest
	- comments-rest

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-udg tyk-stack
```
