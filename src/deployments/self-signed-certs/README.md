## Generate Self Signed Cert for Deployments to use

You can trust the CA on macOS using the following command:
```
sudo security add-trusted-cert \
  -d \
  -r trustRoot \
  -k /Library/Keychains/System.keychain \
  src/deployments/self-signed-certs/certs/tykCA.pem
```
