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

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   | :white_check_mark: |
|   CI Tests   | :white_check_mark: |
| Postman Test |        N/A         |
|     SSL      |        N/A         |

### Supported Service Types with `--expose` flag
|     Item      | Status |
|:-------------:|:------:|
| Port Forward  |  N/A   |
|    Ingress    |  N/A   |
| Load Balancer |  N/A   |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
