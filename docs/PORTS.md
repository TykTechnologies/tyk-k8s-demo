# Ports
All the ports that this library uses.

| Deployment           | Service                                |  Port   |
|----------------------|----------------------------------------|:-------:|
| tyk-stack, tyk-cp    | dashboard-svc-*-tyk-dashboard          | `3000`  |
| portal               | enterprise-portal-svc-*-tyk-dev-portal | `3001`  |
| operator-udg         | users-rest-svc                         | `3101`  |
| operator-udg         | posts-rest-svc                         | `3102`  |
| operator-udg         | comments-rest-svc                      | `3103`  |
| operator-graphql     | users-graph-svc                        | `4101`  |
| operator-graphql     | posts-graph-svc                        | `4102`  |
| operator-graphql     | comments-graph-svc                     | `4103`  |
| operator-graphql     | notifications-graph-svc                | `4104`  |
| operator-federation  | users-subgraph-svc                     | `4201`  |
| operator-federation  | posts-subgraph-svc                     | `4202`  |
| operator-federation  | comments-subgraph-svc                  | `4203`  |
| operator-federation  | notifications-subgraph-svc             | `4204`  |
| datadog              | datadog-agent-health-svc               | `5555`  |
| newrelic             | newrelic-kube-state-metrics-health-svc | `5556`  |
| elasticsearch-kibana | elasticsearch-kibana                   | `5601`  |
| keyclaok             | keycloak-service                       | `7001`  |
| operator-httpbin     | httpbin-svc                            | `8000`  |
| all                  | gateway-svc-*-tyk-gateway              | `8080`  |
| vault                | vault                                  | `8200`  |
| prometheus           | prometheus-server                      | `9080`  |
| prometheus-grafana   | prometheus-grafana                     | `9081`  |
| tyk-cp               | mdcb-svc-*-tyk-mdcb                    | `9090`  |
| prometheus           | pump-svc-*-tyk-pump                    | `9091`  |
| elasticsearch        | elasticsearch                          | `9200`  |
| jaeger               | tyk-jaeger-query                       | `16686` |
