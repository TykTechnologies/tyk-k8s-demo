logger "$INFO" "patching deployments in $namespace namespace...";

gateway=$(kubectl get deployment "gateway-$mode-$chart" --namespace "$namespace" -o json);
dashboard=$(kubectl get deployment "dashboard-$mode-$chart" --namespace "$namespace" -o json);

# Add volume
gateway=$(echo "$gateway" | jq '.spec.template.spec.volumes += [{ "name": "self-signed-ca", "secret": { "secretName": "self-signed-ca-secret" } }]');
dashboard=$(echo "$dashboard" | jq '.spec.template.spec.volumes += [{ "name": "self-signed-ca", "secret": { "secretName": "self-signed-ca-secret" } }]');

# Add volume mount
gateway=$(echo "$gateway" | jq '.spec.template.spec.containers[0].volumeMounts += [{ "name": "self-signed-ca", "mountPath": "/etc/ssl/certs/tykCA.pem", "subPath": "tykCA.pem" }]');
dashboard=$(echo "$dashboard" | jq '.spec.template.spec.containers[0].volumeMounts += [{ "name": "self-signed-ca", "mountPath": "/etc/ssl/certs/tykCA.pem", "subPath": "tykCA.pem" }]');

echo "$gateway" | kubectl apply --namespace "$namespace" -f - > /dev/null;
echo "$dashboard" | kubectl apply --namespace "$namespace" -f - > /dev/null;
