# tyk-k8s-demo
[![tyk-gateway](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-gateway.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-gateway.yml?query=branch%3Amain)
[![tyk-stack](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-stack.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-stack.yml?query=branch%3Amain)
[![tyk-cp](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-cp.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-cp.yml?query=branch%3Amain)
[![tyk-dp](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-dp.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-dp.yml?query=branch%3Amain)
[![Clusters](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/clusters.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/clusters.yml?query=branch%3Amain)
[![Redis](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/redis.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/redis.yml?query=branch%3Amain)
[![Pumps](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-pumps.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-pumps.yml?query=branch%3Amain)

## About
The [tyk-k8s-demo](https://github.com/TykTechnologies/tyk-k8s-demo) library allows you to stand up an entire Tyk Stack
with all its dependencies as well as other tools that can integrate with Tyk.
The library will spin up everything in Kubernetes using `helm` and bash magic
to get you started.

## Purpose
Minimize the amount of effort needed to stand up the Tyk infrastructure and
show examples of how Tyk can be setup in k8s using different deployment
architectures as well as different integrations.

## Getting started

#### Requirements
You will need the following tools to be able to run this library.
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [jq](https://stedolan.github.io/jq/download/)
- [git](https://git-scm.com/downloads)
- [Terraform](https://www.terraform.io/) (only when using `--cloud` flag)

Tested on Linux/Unix based systems on AMD64 and ARM architectures

#### Initial setup
Create `.env` file and update the appropriate fields with your licenses.
If you require a trial license, you can obtain one [here](https://tyk.io/sign-up/).
If you are looking to use the `tyk-gateway` deployment only you will
not require any licensing as that is the open-source deployment.

```
git clone https://github.com/TykTechnologies/tyk-k8s-demo.git
cd tyk-k8s-demo
cp .env.example .env
```

Depending on the deployments you would like install set values of the
`LICENSE`, `MDCB_LICENSE` and `PORTAL_LICENSE` inside the `.env` file.

### Minikube
If you are deploying this on Minikube, you will need to enable the ingress
addon. You do so by running the following:
```
minikube start
minikube addons enable ingress
```

## Quick Start

```
./up.sh --deployments portal,operator-httpbin tyk-stack
```
This quick start command will stand up the entire Tyk stack along with the
Tyk Enterprise Portal and the Tyk Operator and httpbin CRD example.

## Possible deployments
- `tyk-stack`: Tyk single region self-managed deployment
- `tyk-cp`: Tyk self-managed multi region control plane
- `tyk-dp`: Tyk self-managed data plane, this can connect to Tyk Cloud or a Tyk Control Plane
- `tyk-gateway`: Tyk oss self-managed single region

## Dependencies Options
### Redis Options
- `redis`: Bitnami Redis deployment
- `redis-cluster`: Bitnami Redis Cluster deployment
- `redis-sentinel`: Bitnami Redis Sentinel deployment

### Storage Options
- `mongo`: Bitnami Mongo database deployment as a Tyk backend
- `postgres`: Bitnami Postgres database deployment as a Tyk backend

### Supplementary Deployments
Please see this [page](docs/FEATURES_MATRIX.md) for Tyk deployments compatibility charts.
- [cert-manager](src/deployments/cert-manager): deploys cert-manager.
- [datadog](src/deployments/datadog): deploys Datadog agent and stands up a Tyk pump to push analytics data from the Tyk platform to Datadog. It will also create a Datadog dashboard for you to view the analytics.
- [elasticsearch](src/deployments/elasticsearch): deploys Elasticsearch and stands up a Tyk pump to push analytics data from the Tyk platform to Elasticsearch.
	- [elasticsearch-kibana](src/deployments/elasticsearch-kibana): deploys the Elasticsearch deployment as well as a Kibana deployment and creates a Kibana dashboard for you to view the analytics.
- [Jaeger](src/deployments/jaeger): deploys the Jaeger operator, a Jaeger instance, and the OpenTelemetry collector and configures the Tyk deployment to send telemetry data to Jaeger through the OpenTelemetry collector.
- [k6](src/deployments/k6): deploys a Grafana K6 Operator.
	- [k6-slo-traffic](src/deployments/k6-slo-traffic): deploys a k6 CRD to generate a load of traffic to seed analytics data.
- [keycloak](src/deployments/keycloak): deploys the Keycloak Operator and a Keycloak instance.
	- [keycloak-dcr](src/deployments/keycloak-dcr): stands up a Keycloak Dynamic Client Registration example.
	- [keycloak-jwt](src/deployments/keycloak-jwt): stands up a Keycloak JWT Authentication example with Tyk.
	- [keycloak-sso](src/deployments/keycloak-sso): stands up a Keycloak SSO example with the Tyk dashboard.
- [operator](src/deployments/operator): deploys the [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency [cert-manager](https://github.com/jetstack/cert-manager).
	- [operator-federation](src/deployments/operator-federation): stands up a Federation v1 API examples using the tyk-operator.
	- [operator-graphql](src/deployments/operator-graphql): stands up a GraphQL API examples using the tyk-operator.
	- [operator-httpbin](src/deployments/operator-httpbin): stands up an API examples using the tyk-operator.
	- [operator-jwt-hmac](src/deployments/operator-jwt-hmac): stands up an API examples using the tyk-operator to demonstrate JWT HMAC auth.
	- [operator-udg](src/deployments/operator-udg): stands up a Universal Data Graph API examples using the tyk-operator.
- [portal](src/deployments/portal): deploys the [Tyk Enterprise Developer Portal](https://tyk.io/docs/tyk-developer-portal/tyk-enterprise-developer-portal/) as well as its dependency PostgreSQL.
- [prometheus](src/deployments/prometheus): deploys Prometheus and stands up a Tyk pump to push analytics data from the Tyk platform to Prometheus.
	- [prometheus-grafana](src/deployments/prometheus-grafana): deploys the Prometheus deployment as well as a Grafana deployment and creates a Grafana dashboard for you to view the analytics.
- [vault](src/deployments/vault): deploys Vault Operator and a Vault instance.

If you are running a POC and would like an example of how to integrate a
specific tool. Please submit a request through the repository [here](https://github.com/TykTechnologies/tyk-k8s-demo/issues).

### Example
```
./up.sh \
  --storage postgres \
  --deployments prometheus-grafana,k6-slo-traffic \
  tyk-stack
```

The deployment will take 10 minutes as the installation is sequential and the
dependencies require a bit of time before they are stood up. Once the
installation is complete, the script will print out a list of all the services
that were stood up and how those can be accessed. The k6 job will start running
after the script is finished and will run in the background for 15 minutes to
generate traffic over that period of time. To visualize the live traffic, you
can use the credentials provided by the script to access Grafana or the Tyk
Dashboard.

## Usage

### Start Tyk deployment
Create and start up the deployments

```
Usage:
  ./up.sh [flags] [command]

Available Commands:
  tyk-stack
  tyk-cp
  tyk-dp
  tyk-gateway

Flags:
  -v, --verbose         bool     set log level to debug
      --dry-run         bool     set the execution mode to dry run. This will dump the kubectl and helm commands rather than execute them
  -n, --namespace       string   namespace the tyk stack will be installed in, defaults to 'tyk'
  -f, --flavor          enum     k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'
  -e, --expose          enum     set this option to 'port-forward' to expose the services as port-forwards or to 'load-balancer' to expose the services as load balancers or 'ingress' which exposes services as a k8s ingress object
  -r, --redis           enum     the redis mode that tyk stack will use. This option can be set 'redis', 'redis-sentinel' and defaults to 'redis-cluster'
  -s, --storage         enum     database the tyk stack will use. This option can be set 'postgres' and defaults to 'mongo'
  -d, --deployments     string   comma separated list of deployments to launch
  -c, --cloud           enum     stand up k8s infrastructure in 'aws', 'gcp' or 'azure'. This will require Terraform and the CLIs associate with the cloud of choice
  -l, --ssl             bool     enable ssl on deployments
```

### Stop Tyk deployment
Shutdown deployment

```
Usage:
  ./down.sh [flags]

Flags:
  -v, --verbose         bool     set log level to debug
  -n, --namespace       string   namespace the tyk stack will be installed in, defaults to 'tyk'
  -p, --ports           bool     disconnect port connections only
  -c, --cloud           enum     tear down k8s cluster stood up
```

For more information, please see the [docs' folder](docs).
