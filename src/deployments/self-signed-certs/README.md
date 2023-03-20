## Generate Self Signed Cert for Deployments to use

You can trust the CA on macOS using the following command:
```
sudo security add-trusted-cert \
  -d \
  -r trustRoot \
  -k /Library/Keychains/System.keychain \
  src/deployments/self-signed-certs/certs/tykCA.pem
```

You will also need to add the following mappings to your /etc/hosts file
```
127.0.0.1 gateway.tyk.local
127.0.0.1 dashboard.tyk.local
127.0.0.1 portal.tyk.local
127.0.0.1 keycloak.tyk.local
```
