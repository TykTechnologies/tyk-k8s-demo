logger "$INFO" "generating self-signed certs...";

sed "s/replace_namespace/$namespace/g" "$sslPath/tyk.local.template.ext" > "$certsPath/tyk.local.ext"

openssl genrsa \
  -des3 \
  -out "$certsPath/$CAKeyFilename" \
  -passout "pass:$TYK_PASSWORD" \
  2048 > /dev/null;

openssl req \
  -x509 \
  -new \
  -nodes \
  -key "$certsPath/$CAKeyFilename" \
  -sha256 \
  -days 825 \
  -out "$certsPath/$CACertFilename" \
  -passin "pass:$TYK_PASSWORD" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io" > /dev/null;

openssl genrsa \
  -out "$certsPath/$keyFilename" \
  2048 > /dev/null;

openssl req \
  -new \
  -key "$certsPath/$keyFilename" \
  -out "$certsPath/tyk.local.csr" \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io,challengePassword=$TYK_PASSWORD" > /dev/null;

openssl x509 \
  -req \
  -in "$certsPath/tyk.local.csr" \
  -CA "$certsPath/$CACertFilename" \
  -CAkey "$certsPath/$CAKeyFilename" \
  -CAcreateserial \
  -out "$certsPath/$certFilename" \
  -days 825 \
  -sha256 \
  -extfile "$certsPath/tyk.local.ext" \
  -passin "pass:$TYK_PASSWORD" > /dev/null;
