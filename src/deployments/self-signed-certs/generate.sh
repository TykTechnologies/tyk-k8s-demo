logger "$INFO" "generating self-signed certs...";

openssl genrsa \
  -des3 \
  -out "$deploymentPath/certs/tykCA.key" \
  -passout "pass:$PASSWORD" \
  2048 > /dev/null;

openssl req \
  -x509 \
  -new \
  -nodes \
  -key "$deploymentPath/certs/tykCA.key" \
  -sha256 \
  -days 825 \
  -out "$deploymentPath/certs/tykCA.pem" \
  -passin "pass:$PASSWORD" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io" > /dev/null;

openssl genrsa \
  -out "$deploymentPath/certs/tyk.local.key" \
  2048 > /dev/null;

openssl req \
  -new \
  -key "$deploymentPath/certs/tyk.local.key" \
  -out "$deploymentPath/certs/tyk.local.csr" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io,challengePassword=$PASSWORD" > /dev/null;

openssl x509 \
  -req \
  -in "$deploymentPath/certs/tyk.local.csr" \
  -CA "$deploymentPath/certs/tykCA.pem" \
  -CAkey "$deploymentPath/certs/tykCA.key" \
  -CAcreateserial \
  -out "$deploymentPath/certs/tyk.local.crt" \
  -days 825 \
  -sha256 \
  -extfile "$deploymentPath/certs/tyk.local.ext" \
  -passin "pass:$PASSWORD" > /dev/null;
