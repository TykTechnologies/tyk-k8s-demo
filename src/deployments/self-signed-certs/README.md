## Self Singed Certs
This deployment will generate self-signed certs for apps to use and adds them to trusted stores.

You can trust the CA on macOS using the following command:
```
sudo security add-trusted-cert \
  -d \
  -r trustRoot \
  -k /Library/Keychains/System.keychain \
  src/deployments/self-signed-certs/certs/tykCA.pem
```
