# Features, Tests, and Support matrices

| Deployment           | OpenShift Support  |    ARM Support     |      CI Tests      |    Postman Test    |        SSL         |                                              Chart/Manifest                                              | Version |
|----------------------|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:--------------------------------------------------------------------------------------------------------:|:-------:|
| tyk-gateway          | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                        [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-oss                        |  1.6.0  |
| tyk-dp               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-data-plane                     |  1.6.0  |
| tyk-stack            | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                       [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-stack                       |  1.6.0  |
| tyk-cp               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                   [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-control-plane                   |  1.6.0  |
| cert-manager         | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |        N/A         |                           [jetstack](https://charts.jetstack.io)/cert-manager                            | 1.15.1  |
| datadog              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |                              [datadog](https://helm.datadoghq.com)/datadog                               | 3.69.0  |
| elasticsearch        | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                       [bitnami](https://charts.bitnami.com/bitnami)/elasticsearch                        | 21.3.5  |
| elasticsearch-kibana | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                           [bitnami](https://charts.bitnami.com/bitnami)/kibana                           | 11.2.14 |
| jaeger               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |               [jaegertracing](https://jaegertracing.github.io/helm-charts)/jaeger-operator               | 2.46.2  |
| k6                   | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |        N/A         |                       [grafana](https://grafana.github.io/helm-charts)/k6-operator                       |  3.7.0  |
| k6-slo-traffic       |        N/A         |        N/A         | :white_check_mark: |        N/A         |        N/A         |                                                   N/A                                                    |   N/A   |
| keycloak             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | [keycloak-operator](https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes) | 25.0.2  |
| keycloak-dcr         |        N/A         |        N/A         | :white_check_mark: |        N/A         |        N/A         |                                                   N/A                                                    |   N/A   |
| keycloak-jwt         |        N/A         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |                                                   N/A                                                    |   N/A   |
| keycloak-sso         |        N/A         |        N/A         | :white_check_mark: |        N/A         |        N/A         |                                                   N/A                                                    |   N/A   |
| newrelic             |     :warning:      | :white_check_mark: | :white_check_mark: |        N/A         |        N/A         |                             [nri-bundle](https://helm-charts.newrelic.com/)                              | 5.0.87  |
| opa                  |        N/A         |        N/A         |        N/A         |        N/A         |        N/A         |                                                   N/A                                                    |   N/A   |
| opensearch           | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                         [bitnami](https://charts.bitnami.com/bitnami)/opensearch                         |  1.2.8  |
| operator             | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |        N/A         |                     [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-operator                      | 0.18.0  |
| operator-federation  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                                                   N/A                                                    |   N/A   |
| operator-graphql     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |                                                   N/A                                                    |   N/A   |
| operator-httpbin     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                                                   N/A                                                    |   N/A   |
| operator-jwt-hmac    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |                                                   N/A                                                    |   N/A   |
| operator-udg         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                                                   N/A                                                    |   N/A   |
| portal               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-dev-portal                     |  1.6.0  |
| prometheus           |     :no_entry:     | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |          [prometheus-community](https://prometheus-community.github.io/helm-charts)/prometheus           | 25.24.1 |
| prometheus-grafana   |     :warning:      | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                         [grafana](https://grafana.github.io/helm-charts)/grafana                         |  8.3.6  |
| vault                | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                          [hashicorp](https://helm.releases.hashicorp.com)/vault                          | 0.28.1  |


## Integrations compatible with Tyk deployments
| Integration          |    tyk-gateway     |     tyk-stack      |       tyk-cp       |       tyk-dp       |
|----------------------|:------------------:|:------------------:|:------------------:|:------------------:|
| datadog              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| elasticsearch        | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| elasticsearch-kibana | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| jaeger               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| k6                   | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| k6-slo-traffic       | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| keycloak             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| keycloak-dcr         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |
| keycloak-jwt         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| keycloak-sso         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |
| newrelic             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| opa                  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-federation  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-graphql     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-httpbin     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-jwt-hmac    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-udg         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| portal               |        N/A         | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus           | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus-grafana   | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| vault                | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |

## `--expose` flag support
| Deployment           |    port-froward    |      ingress       |   load-balancer    |
|----------------------|:------------------:|:------------------:|:------------------:|
| tyk-gateway          | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-dp               | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-stack            | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-cp               | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| datadog              | :white_check_mark: |        N/A         |        N/A         |
| elasticsearch        | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| elasticsearch-kibana | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| jaeger               | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| k6                   |        N/A         |        N/A         |        N/A         |
| k6-slo-traffic       |        N/A         |        N/A         |        N/A         |
| keycloak             | :white_check_mark: |     :no_entry:     |     :no_entry:     |
| keycloak-dcr         |        N/A         |        N/A         |        N/A         |
| keycloak-jwt         |        N/A         |        N/A         |        N/A         |
| keycloak-sso         |        N/A         |        N/A         |        N/A         |
| newrelic             |        N/A         |        N/A         |        N/A         |
| opa                  |        N/A         |        N/A         |        N/A         |
| opensearch           | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator             |        N/A         |        N/A         |        N/A         |
| operator-federation  | :white_check_mark: |        :x:         |        :x:         |
| operator-graphql     |        N/A         |        N/A         |        N/A         |
| operator-httpbin     | :white_check_mark: |        :x:         |        :x:         |
| operator-jwt-hmac    |        N/A         |        N/A         |        N/A         |
| operator-udg         | :white_check_mark: |        :x:         |        :x:         |
| portal               | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus           | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus-grafana   | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| vault                | :white_check_mark: |        :x:         |        :x:         |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
