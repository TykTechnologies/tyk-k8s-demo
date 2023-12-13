## Keycloak JWT Authentication
Deploys the Keycloak Operator and a Keycloak instance and the JWT realm.

Keycloak Operator is installed using the
[21.0.1](https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes)
Keycloak resource.

### Retrieve JWT
You can retrieve JWT using the password grant or the client credential
approaches.

#### Password Grant
Example curl to fetch the token through password grant flow
```
curl -L -s -X POST 'http://localhost:7001/realms/jwt/protocol/openid-connect/token' \
		-H 'Content-Type: application/x-www-form-urlencoded' \
		--data-urlencode 'client_id=keycloak-jwt' \
		--data-urlencode 'grant_type=password' \
		--data-urlencode 'client_secret=wcl7lBoslXBMAHKinMwa1bbEuBQSCUtI' \
		--data-urlencode 'scope=openid' \
		--data-urlencode 'username=default@example.com' \
		--data-urlencode 'password=topsecretpassword'
```

#### Client Credentials
Example curl to fetch the token through password grant flow
```
curl -L -s -X POST 'http://localhost:7001/realms/jwt/protocol/openid-connect/token' \
		-H 'Content-Type: application/x-www-form-urlencoded' \
		--data-urlencode 'client_id=keycloak-jwt' \
		--data-urlencode 'grant_type=client_credentials' \
		--data-urlencode 'client_secret=wcl7lBoslXBMAHKinMwa1bbEuBQSCUtI'
```

### Test Authentication
```
curl 'http://localhost:8080/keycloak-jwt/get' \
		-H "Authorization: Bearer $token"
```

### Example
```
./up.sh --deployments keycloak-jwt tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   |        N/A         |
|     ARM      |        N/A         |
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
