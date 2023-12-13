## Keycloak
Deploys the Keycloak Operator and a Keycloak instance.

Keycloak Operator is installed using the
[21.0.1](https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes)
Keycloak resource.

### Example
```
./up.sh --deployments keycloak tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   | :white_check_mark: |
|     ARM      | :white_check_mark: |
|   CI Tests   | :white_check_mark: |
| Postman Test | :white_check_mark: |
|     SSL      | :white_check_mark: |

### Supported Service Types with `--expose` flag
|     Item      |       Status       |
|:-------------:|:------------------:|
| Port Forward  | :white_check_mark: |
|    Ingress    |     :no_entry:     |
| Load Balancer |     :no_entry:     |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
