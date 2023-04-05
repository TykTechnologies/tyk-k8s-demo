# tyk-k8s-demo
[![tyk-gateway](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-gateway.yml/badge.svg)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-gateway.yml)
[![tyk-stack](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-stack.yml/badge.svg)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-stack.yml)
[![tyk-cp](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-cp.yml/badge.svg)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-cp.yml)
[![tyk-dp](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-dp.yml/badge.svg)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-dp.yml)
[![Clusters](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/clusters.yml/badge.svg)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/clusters.yml)
[![Redis](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/redis.yml/badge.svg)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/redis.yml)

## About
Will allow you to deploy the entire Tyk stack for POC on k8s.

## Purpose
Minimize the amount of effort needed to stand up the Tyk infrastructure and show examples of how Tyk can be setup in k8s using different deployment architectures as well as different integrations.

## Getting started

#### Requirements
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [jq](https://stedolan.github.io/jq/download/)
- [git](https://git-scm.com/downloads)
- [Terraform](https://www.terraform.io/) (only when using `--cloud` flag)

#### Initial setup
Create `.env` file and update the appropriate fields with your licenses. If you require a trial license you can obtain one
[here](https://tyk.io/sign-up/). If you are looking to use the `tyk-gateway` deployment only you will not require any licensing
as that is the open source deployment.

```
git clone https://github.com/TykTechnologies/tyk-k8s-demo.git
cd tyk-k8s-demo
cp .env.example .env
```

### Minikube
If you are deploying this on Minikube you will need to enable the ingress addon. You do so by running the following:
```
minikube start
minikube addons enable ingress
```

## Quick Start

```
./up.sh --deployments portal,operator-httpbin tyk-stack
```
This quick start command will stand up the entire Tyk stack along with the Tyk Enterprise Portal and the Tyk Operator and httpbin CRD example.

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
- [Datadog](src/deployments/datadog): connects tyk deployments analytics and logs to datadog.
- [Elasticsearch](src/deployments/elasticsearch): connects tyk deployments analytics to elasticsearch.
  - [Kibana](src/deployments/elasticsearch-kibana): connects a Kibana installment to the elasticsearch deployment.
- [k6](src/deployments/k6): generates a load of traffic to seed analytical data.
  - [SLO Traffic](src/deployments/k6-slo-traffic): generates a load of traffic to seed analytical data.
- [Keycloak](src/deployments/keycloak): stands up a keycloak deployment.
  - [DCR](src/deployments/keycloak-dcr): stands up a keycloak Dynamic Client Registration example.
  - [SSO](src/deployments/keycloak-sso): stands up a keycloak SSO example with Tyk dashboard.
- [Operator](src/deployments/operator): this deployment option will install the [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency [cert-manager](https://github.com/jetstack/cert-manager).
	- [HttpBin](src/deployments/operator-httpbin): creates API examples using the tyk-operator.
	- [GraphQL](src/deployments/operator-graphql): creates GraphQL API examples using the tyk-operator.
	- [Universal Data Graph](src/deployments/operator-udg): creates Universal Data Graph API examples using the tyk-operator.
	- [Federation v1](src/deployments/operator-federation): creates Federation v1 API examples using the tyk-operator.
- [Portal](src/deployments/portal): this deployment will install the [Tyk Enterprise Developer Portal](https://tyk.io/docs/tyk-developer-portal/tyk-enterprise-developer-portal/) as well as its dependency PostgreSQL.
- [Prometheus](src/deployments/prometheus): this deployment will stand up a Tyk Prometheus pump with custom analytics.
  - [Grafana](src/deployments/prometheus-grafana): connects a Grafana installment to the Prometheus deployment.

### Example
```
./up.sh \
  --storage postgres \
  --deployments prometheus-grafana \
  tyk-stack
```

The deployment will take 10 minutes as the installation is sequential and the dependencies require a bit of time before
they are stood up. Once the installation is complete the script will print out a list of all the services that were
stood up and how those can be accessed. The k6s job will start running after the script is finished and will run in the
background for 15 minutes to generate traffic over that period of time. To visualize the live traffic you can use the
credentials provided by the script to access Grafana or the Tyk Dashboard.

## Usage
```
Usage:
  ./up.sh [flags] [command]

Available Commands:
  tyk-stack
  tyk-cp
  tyk-dp
  tyk-gateway

Flags:
  -v, --verbose     	bool   	 set log level to debug
      --dry-run     	bool   	 set the execution mode to dry run. This will dump the kubectl and helm commands rather than execute them
  -n, --namespace   	string 	 namespace the tyk stack will be installed in, defaults to 'tyk'
  -f, --flavor      	enum   	 k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'
  -e, --expose      	enum   	 set this option to 'port-forward' to expose the services as port-forwards or to 'load-balancer' to expose the services as load balancers or 'ingress' which exposes services as a k8s ingress object. Defaults to 'port-forward'
  -r, --redis       	enum   	 the redis mode that tyk stack will use. This option can be set 'redis', 'redis-sentinel' and defaults to 'redis-cluster'
  -s, --storage     	enum   	 database the tyk stack will use. This option can be set 'mongo' and defaults to 'postgres'
  -d, --deployments 	string 	 comma separated list of deployments to launch
  -c, --cloud       	enum   	 stand up k8s infrastructure in 'aws', 'gcp' or 'azure'. This will require Terraform and the CLIs associate with the cloud of choice
```

```
Usage:
  ./down.sh [flags]

Flags:
  -v, --verbose   	bool   	 set log level to debug
  -n, --namespace 	string 	 namespace the tyk stack will be installed in, defaults to 'tyk'
  -p, --ports     	bool   	 disconnect port connections only
  -c, --cloud     	enum     tear down k8s cluster stood up
```

For more information please see the [docs folder](docs).
