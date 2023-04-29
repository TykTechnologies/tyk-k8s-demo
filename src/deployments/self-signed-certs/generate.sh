logger "$INFO" "generating self-signed certs...";

openssl genrsa \
  -des3 \
  -out "$selfSignedCertsDeploymentPath/certs/tykCA.key" \
  -passout "pass:$PASSWORD" \
  2048 > /dev/null;

openssl req \
  -x509 \
  -new \
  -nodes \
  -key "$selfSignedCertsDeploymentPath/certs/tykCA.key" \
  -sha256 \
  -days 825 \
  -out "$selfSignedCertsDeploymentPath/certs/tykCA.pem" \
  -passin "pass:$PASSWORD" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io" > /dev/null;

openssl genrsa \
  -out "$selfSignedCertsDeploymentPath/certs/tyk.local.key" \
  2048 > /dev/null;

openssl req \
  -new \
  -key "$selfSignedCertsDeploymentPath/certs/tyk.local.key" \
  -out "$selfSignedCertsDeploymentPath/certs/tyk.local.csr" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io,challengePassword=$PASSWORD" > /dev/null;

openssl x509 \
  -req \
  -in "$selfSignedCertsDeploymentPath/certs/tyk.local.csr" \
  -CA "$selfSignedCertsDeploymentPath/certs/tykCA.pem" \
  -CAkey "$selfSignedCertsDeploymentPath/certs/tykCA.key" \
  -CAcreateserial \
  -out "$selfSignedCertsDeploymentPath/certs/tyk.local.crt" \
  -days 825 \
  -sha256 \
  -extfile "$selfSignedCertsDeploymentPath/certs/tyk.local.ext" \
  -passin "pass:$PASSWORD" > /dev/null;
