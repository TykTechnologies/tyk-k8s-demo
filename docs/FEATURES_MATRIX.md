# Features, Tests, Ports, and Support matrices

| Deployment           |             `--expose` Support             | OpenShift Support  |    ARM Support     |      CI Tests      |    Postman Test    |
|----------------------|:------------------------------------------:|:------------------:|:------------------:|:------------------:|:------------------:|
| tyk-gateway          | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-dp               | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-stack            | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-cp               | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| datadog              |               `port-froward`               | :white_check_mark: | :white_check_mark: |        :x:         | :white_check_mark: |
| elasticsearch        |               `port-froward`               | :white_check_mark: | :white_check_mark: |        :x:         | :white_check_mark: |
| elasticsearch-kibana |               `port-froward`               | :white_check_mark: | :white_check_mark: |        :x:         | :white_check_mark: |
| k6                   |                    N/A                     |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| k6-slo-traffic       |                    N/A                     |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak             |               `port-froward`               |        :x:         |        :x:         | :white_check_mark: | :white_check_mark: |
| keycloak-dcr         |                    N/A                     |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak-sso         |                    N/A                     |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak-jwt         |                    N/A                     |        :x:         |        :x:         |        :x:         | :white_check_mark: |
| operator             |                    N/A                     | :white_check_mark: | :white_check_mark: | :white_check_mark: |        :x:         |
| operator-httpbin     |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-graphql     |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-udg         |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-federation  |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-jwt-hmac    |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| portal               | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus           |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus-grafana   |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| resurface            |               `port-froward`               |        :x:         |        :x:         | :white_check_mark: |        :x:         |


## Integrations compatible with Tyk deployments
| Integration          |    tyk-gateway     |     tyk-stack      |       tyk-cp       |       tyk-dp       |
|----------------------|:------------------:|:------------------:|:------------------:|:------------------:|
| datadog              |        :x:         | :white_check_mark: | :white_check_mark: |        :x:         |
| elasticsearch        |        :x:         | :white_check_mark: | :white_check_mark: |        :x:         |
| elasticsearch-kibana |        :x:         | :white_check_mark: | :white_check_mark: |        :x:         |
| k6                   | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| k6-slo-traffic       | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| keycloak             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| keycloak-dcr         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |
| keycloak-sso         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |
| keycloak-jwt         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-httpbin     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-graphql     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-udg         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-federation  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-jwt-hmac    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| portal               |        N/A         | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus           |        :x:         | :white_check_mark: | :white_check_mark: |        :x:         |
| prometheus-grafana   |        :x:         | :white_check_mark: | :white_check_mark: |        :x:         |
