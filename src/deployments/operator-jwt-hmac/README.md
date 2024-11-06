## Tyk Operator JWT HMAC Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a Federation v1 API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- JWT Authentication Example

### Token
The token is generated using the shared key-phrase `topsecretpassword`

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.8TKYxZ1838CRmpf7cZ2tU673Jm1swSfb-Mgp9AwzIv0
```

You can test is by sending a request to the gateway at `/jwt-hmac/get` with
the header `Authorization: Bearer $token`

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-jwt-hmac tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |        N/A         |
|   CI Tests   | :white_check_mark: |
| Postman Test | :white_check_mark: |
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
