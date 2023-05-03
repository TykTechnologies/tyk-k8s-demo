## Keycloak OIDC Authentication

Example curl to fetch the token through password grant flow
```
curl -L --insecure -s -X POST 'https://localhost:7001/realms/jwt/protocol/openid-connect/token' \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	--data-urlencode 'client_id=oidc-client' \
	--data-urlencode 'grant_type=password' \
	--data-urlencode 'client_secret=5yCQ2p8hg7jz4NwHo5QAqP0PqSOgMpKv' \
	--data-urlencode 'scope=openid' \
	--data-urlencode 'username=default@example.com' \
	--data-urlencode 'password=topsecretpassword'
```

Example curl against gateway with token
```
curl 'http://localhost:8080/keycloak-oidc/get' \
	-H "Authorization: Bearer $token"
```
