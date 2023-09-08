## Keycloak JWT Authentication
Sets up an example API with JWT Authentication enabled through Keycloak

### Password Grant
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


### Client Credentials
Example curl to fetch the token through password grant flow
```
curl -L -s -X POST 'http://localhost:7001/realms/jwt/protocol/openid-connect/token' \
		-H 'Content-Type: application/x-www-form-urlencoded' \
		--data-urlencode 'client_id=keycloak-jwt' \
		--data-urlencode 'grant_type=client_credentials' \
		--data-urlencode 'client_secret=wcl7lBoslXBMAHKinMwa1bbEuBQSCUtI'
```

### Test
```
curl 'http://localhost:8080/keycloak-jwt/get' \
		-H "Authorization: Bearer $token"
```
