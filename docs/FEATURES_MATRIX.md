# Features, Tests, and Support matrices

| Deployment           | OpenShift Support  |    ARM Support     |      CI Tests      |    Postman Test    |        SSL         |                                                  Chart/Manifest                                                   | Version |
|----------------------|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:-----------------------------------------------------------------------------------------------------------------:|:-------:|
| tyk-gateway          | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                            [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-oss                             |  1.2.0  |
| tyk-dp               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                         [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-data-plane                         |  1.1.0  |
| tyk-stack            | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                           [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-stack                            |  1.0.0  |
| tyk-cp               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                                                         -                                                         |    -    |
| cert-manager         | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |        N/A         |                                [jetstack](https://charts.jetstack.io)/cert-manager                                | 1.10.1  |
| datadog              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |                                   [datadog](https://helm.datadoghq.com)/datadog                                   | 3.25.1  |
| elasticsearch        | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                            [bitnami](https://charts.bitnami.com/bitnami)/elasticsearch                            | 19.13.1 |
| elasticsearch-kibana | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                               [bitnami](https://charts.bitnami.com/bitnami)/kibana                                | 10.5.6  |
| jaeger               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                   [jaegertracing](https://jaegertracing.github.io/helm-charts)/jaeger-operator                    | 2.46.2  |
| k6                   | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |        N/A         |                           [grafana](https://grafana.github.io/helm-charts)/k6-operator                            |  1.2.0  |
| k6-slo-traffic       |        N/A         |        N/A         | :white_check_mark: |        N/A         |        N/A         |                                                        N/A                                                        |   N/A   |
| keycloak             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     [keycloak-operator](https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/21.0.1/kubernetes)      | 21.0.1  |
| keycloak-dcr         |        N/A         |        N/A         | :white_check_mark: |        N/A         |        N/A         |                                                        N/A                                                        |   N/A   |
| keycloak-jwt         |        N/A         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |                                                        N/A                                                        |   N/A   |
| keycloak-sso         |        N/A         |        N/A         | :white_check_mark: |        N/A         |        N/A         |                                                        N/A                                                        |   N/A   |
| operator             | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |        N/A         |                          [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-operator                          | 0.17.0  |
| operator-federation  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                                                        N/A                                                        |   N/A   |
| operator-graphql     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |                                                        N/A                                                        |   N/A   |
| operator-httpbin     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                                                        N/A                                                        |   N/A   |
| operator-jwt-hmac    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |        N/A         |                                                        N/A                                                        |   N/A   |
| operator-udg         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                                                        N/A                                                        |   N/A   |
| portal               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                         [tyk-helm](https://helm.tyk.io/public/helm/charts)/tyk-dev-portal                         |  1.0.0  |
| prometheus           |     :no_entry:     | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |               [prometheus-community](https://prometheus-community.github.io/helm-charts)/prometheus               | 25.3.0  |
| prometheus-grafana   |     :warning:      | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                             [grafana](https://grafana.github.io/helm-charts)/grafana                              | 6.52.7  |
| vault                | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :no_entry:     |                              [hashicorp](https://helm.releases.hashicorp.com)/vault                               | 0.27.0  |


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
