# Features, Tests, Ports, and Support matrices

### Expose
| Deployment           |             `--expose` Support             |
|----------------------|:------------------------------------------:|
| tyk-gateway          | `port-froward`, `ingress`, `load-balancer` |
| tyk-dp               | `port-froward`, `ingress`, `load-balancer` |
| tyk-stack            | `port-froward`, `ingress`, `load-balancer` |
| tyk-cp               | `port-froward`, `ingress`, `load-balancer` |
| elasticsearch        |               `port-froward`               |
| elasticsearch-kibana |               `port-froward`               |
| k6                   |                    N/A                     |
| k6-slo-traffic       |                    N/A                     |
| operator             |                    N/A                     |
| operator-httpbin     |               `port-froward`               |
| operator-graphql     |               `port-froward`               |
| operator-udg         |               `port-froward`               |
| operator-federation  |               `port-froward`               |
| portal               | `port-froward`, `ingress`, `load-balancer` |
| prometheus           |               `port-froward`               |
| prometheus-grafana   |               `port-froward`               |

### OpenShift Support
| Deployment           | OpenShift Support  |
|----------------------|:------------------:|
| tyk-gateway          | :white_check_mark: |
| tyk-dp               | :white_check_mark: |
| tyk-stack            | :white_check_mark: |
| tyk-cp               | :white_check_mark: |
| elasticsearch        | :white_check_mark: |
| elasticsearch-kibana | :white_check_mark: |
| k6                   | :white_check_mark: |
| k6-slo-traffic       | :white_check_mark: |
| operator             | :white_check_mark: |
| operator-httpbin     | :white_check_mark: |
| operator-graphql     | :white_check_mark: |
| operator-udg         | :white_check_mark: |
| operator-federation  | :white_check_mark: |
| portal               | :white_check_mark: |
| prometheus           | :white_check_mark: |
| prometheus-grafana   | :white_check_mark: |

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


### Tests
| Deployment           |   Postman Tests    |
|----------------------|:------------------:|
| tyk-gateway          | :white_check_mark: |
| tyk-dp               | :white_check_mark: |
| tyk-stack            | :white_check_mark: |
| tyk-cp               | :white_check_mark: |
| elasticsearch        |        N/A         |
| elasticsearch-kibana |        N/A         |
| k6                   |        N/A         |
| k6-slo-traffic       |        N/A         |
| operator             |        N/A         |
| operator-httpbin     |   :construction:   |
| operator-graphql     |   :construction:   |
| operator-udg         |   :construction:   |
| operator-federation  |   :construction:   |
| portal               |   :construction:   |
| prometheus           |   :construction:   |
| prometheus-grafana   |   :construction:   |
