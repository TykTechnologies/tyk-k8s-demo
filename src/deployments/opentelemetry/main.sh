logger "$INFO" "installing $opentelemetrReleaseName in $namespace namespace...";

setVerbose;
helm upgrade tyk-otel-collector opentelemetry/opentelemetry-collector --version 0.108.1 \
  --install \
  --set "mode=deployment" \
  --set "image.repository=otel/opentelemetry-collector-contrib" \
  --set "config.receivers.otlp.protocols.http.endpoint=0.0.0.0:4318" \
  --set "config.receivers.otlp.protocols.grpc.endpoint=0.0.0.0:4317" \
  --set "config.processors.transform.error_mode=ignore" \
  --set "config.processors.transform.metric_statements[0].context=datapoint" \
  --set "config.processors.transform.metric_statements[0].statements[0]=replace_all_patterns(attributes\, \"value\"\, \"[^a-zA-Z0-9]\"\, \"_\")" \
  --set "config.exporters.otlp/tempo.endpoint=$tempoReleaseName.$namespace.svc:4317" \
  --set "config.exporters.otlp/tempo.tls.insecure=true" \
  --set "config.extensions.pprof.endpoint=\:1888" \
  --set "config.extensions.zpages.endpoint=\:55679" \
  --set "config.service.extensions[0]=pprof" \
  --set "config.service.extensions[1]=zpages" \
  --set "config.service.extensions[2]=health_check" \
  --set "config.service.pipelines.traces.receivers[0]=otlp" \
  --set "config.service.pipelines.traces.processors[0]=batch" \
  --set "config.service.pipelines.traces.exporters[0]=otlp/tempo" \
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
