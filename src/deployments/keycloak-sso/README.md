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
