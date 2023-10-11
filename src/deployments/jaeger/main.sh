logger "$INFO" "installing $jaegerReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$jaegerReleaseName" jaegertracing/jaeger-operator --version v2.46.2 \
  --install \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;

kubectl apply -n "$namespace" -f "$jaegerDeploymentPath/jaeger.yaml" > /dev/null;

helm upgrade tyk-otel-collector open-telemetry/opentelemetry-collector --version 0.62.0 \
  --install \
  --set "mode=deployment" \
  --set "config.receivers.otlp.protocols.http.endpoint=0.0.0.0:4318" \
  --set "config.receivers.otlp.protocols.grpc.endpoint=0.0.0.0:4317" \
  --set "config.exporters.jaeger.endpoint=$jaegerReleaseName-collector.$namespace.svc:14250" \
  --set "config.exporters.jaeger.tls.insecure=true" \
  --set "config.extensions.pprof.endpoint=\:1888" \
  --set "config.extensions.zpages.endpoint=\:55679" \
  --set "config.service.extensions[0]=pprof" \
  --set "config.service.extensions[1]=zpages" \
  --set "config.service.extensions[2]=health_check" \
  --set "config.service.pipelines.traces.receivers[0]=otlp" \
  --set "config.service.pipelines.traces.processors[0]=batch" \
  --set "config.service.pipelines.traces.exporters[0]=jaeger" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;

args=(--set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].name=TYK_GW_OPENTELEMETRY_ENABLED" \
  --set-string "tyk-gateway.gateway.extraEnvs[$gatewayExtraEnvsCtr].value=true" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 1))].name=TYK_GW_OPENTELEMETRY_EXPORTER" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 1))].value=grpc" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 2))].name=TYK_GW_OPENTELEMETRY_ENDPOINT" \
  --set-string "tyk-gateway.gateway.extraEnvs[$(($gatewayExtraEnvsCtr + 2))].value=tyk-otel-collector-opentelemetry-collector:4317");

gatewayExtraEnvsCtr=$((gatewayExtraEnvsCtr + 3));

addDeploymentArgs "${args[@]}";
upgradeTyk;

sed "s/replace_release_name/$jaegerReleaseName/g" "$jaegerDeploymentPath/jaeger-health-svc-template.yaml" | \
  sed "s/replace_namespace/$namespace/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

addService "$jaegerReleaseName-query";
addService "$jaegerReleaseName-health";
