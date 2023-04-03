# Features, Tests, Ports, and Support matrices

| Deployment           |             `--expose` Support             | OpenShift Support  |    ARM Support     |      CI Tests      |    Postman Test    |
|----------------------|:------------------------------------------:|:------------------:|:------------------:|:------------------:|:------------------:|
| tyk-gateway          | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-dp               | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-stack            | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-cp               | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| datadog              |               `port-froward`               | :white_check_mark: | :white_check_mark: |        :x:         |        :x:         |
| elasticsearch        |               `port-froward`               | :white_check_mark: | :white_check_mark: |        :x:         |        :x:         |
| elasticsearch-kibana |               `port-froward`               | :white_check_mark: | :white_check_mark: |        :x:         |        :x:         |
| k6                   |                    N/A                     |        :x:         | :white_check_mark: | :white_check_mark: |        :x:         |
| k6-slo-traffic       |                    N/A                     |        :x:         | :white_check_mark: | :white_check_mark: |        :x:         |
| keycloak             |               `port-froward`               |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak-dcr         |                    N/A                     |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak-sso         |                    N/A                     |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| operator             |                    N/A                     | :white_check_mark: |        :x:         | :white_check_mark: |        :x:         |
| operator-httpbin     |               `port-froward`               | :white_check_mark: |        :x:         | :white_check_mark: |        :x:         |
| operator-graphql     |               `port-froward`               | :white_check_mark: |        :x:         | :white_check_mark: | :white_check_mark: |
| operator-udg         |               `port-froward`               | :white_check_mark: |        :x:         | :white_check_mark: | :white_check_mark: |
| operator-federation  |               `port-froward`               | :white_check_mark: |        :x:         | :white_check_mark: | :white_check_mark: |
| portal               | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: | :white_check_mark: |        :x:         |
| prometheus           |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: |        :x:         |
| prometheus-grafana   |               `port-froward`               | :white_check_mark: | :white_check_mark: | :white_check_mark: |        :x:         |

### Ports
| Service                |  Port  |
|------------------------|:------:|
| gateway                | `8080` |
| dashboard              | `3000` |
| MDCB                   | `9090` |
| portal                 | `3001` |
| httpbin                | `8000` |
| users-rest             | `3101` |
| posts-rest             | `3102` |
| comments-rest          | `3103` |
| users-subgraph         | `4201` |
| posts-subgraph         | `4202` |
| comments-subgraph      | `4203` |
| notifications-subgraph | `4204` |
| prometheus pump        | `9091` |
| prometheus             | `9080` |
| grafana                | `9081` |
| keycloak               | `7001` |
| elastcisearch          | `9200` |
| kibana                 | `5601` |
| keyclaok               | `7001` |
