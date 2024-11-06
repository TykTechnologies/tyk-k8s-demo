## Keycloak SSO
Deploys the Keycloak Operator and a Keycloak instance and the SSO realm.

Keycloak Operator is installed using the
[21.0.1](https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes)
Keycloak resource.

This deployment will create a Tyk Dashboard - Tyk Identity Provider Profile to
manage Tyk Dashboard login.

Please add `127.0.0.1 keycloak-service.{namespace}.svc` for the SSO to work on
localhost.

### Example
```
./up.sh --deployments keycloak-sso tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |        N/A         |
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

