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
