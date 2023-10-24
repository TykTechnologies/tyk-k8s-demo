## Keycloak Dynamic Client Registration
Deploys the Keycloak Operator and a Keycloak instance and the DCR realm.

Keycloak Operator is installed using the
[21.0.1](https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes)
Keycloak resource.

This deployment will allow you to get started with our DCR example.
You can continue with this example by following [this](https://tyk.io/docs/nightly/tyk-stack/tyk-developer-portal/enterprise-developer-portal/api-access/dynamic-client-registration)
documentation page.

### Example
```
./up.sh --deployments keycloak-dcr tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |        N/A         |
|     ARM      |        N/A         |
|   CI Tests   | :white_check_mark: |
| Postman Test |        N/A         |
|     SSL      |        N/A         |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |

