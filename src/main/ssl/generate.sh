logger "$INFO" "generating self-signed certs...";

sed "s/replace_namespace/$namespace/g" "$sslPath/tyk.local.template.ext" > "$certsPath/tyk.local.ext"

openssl genrsa \
  -des3 \
  -out "$certsPath/tykCA.key" \
  -passout "pass:$PASSWORD" \
  2048 > /dev/null;

openssl req \
  -x509 \
  -new \
  -nodes \
  -key "$certsPath/tykCA.key" \
  -sha256 \
  -days 825 \
  -out "$certsPath/tykCA.pem" \
  -passin "pass:$PASSWORD" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io" > /dev/null;

openssl genrsa \
  -out "$certsPath/tyk.local.key" \
  2048 > /dev/null;

openssl req \
  -new \
  -key "$certsPath/tyk.local.key" \
  -out "$certsPath/tyk.local.csr" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io,challengePassword=$PASSWORD" > /dev/null;

openssl x509 \
  -req \
  -in "$certsPath/tyk.local.csr" \
  -CA "$certsPath/tykCA.pem" \
  -CAkey "$certsPath/tykCA.key" \
  -CAcreateserial \
  -out "$certsPath/tyk.local.crt" \
  -days 825 \
  -sha256 \
  -extfile "$certsPath/tyk.local.ext" \
  -passin "pass:$PASSWORD" > /dev/null;
