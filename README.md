# tyk-k8s-demo
[![tyk-gateway](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-gateway.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-gateway.yml?query=branch%3Amain)
[![tyk-stack](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-stack.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-stack.yml?query=branch%3Amain)
[![tyk-cp](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-cp.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-cp.yml?query=branch%3Amain)
[![tyk-dp](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-dp.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/tyk-dp.yml?query=branch%3Amain)
[![Clusters](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/clusters.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/clusters.yml?query=branch%3Amain)
[![Redis](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/redis.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/redis.yml?query=branch%3Amain)
[![Storage](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/storage.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/storage.yml?query=branch%3Amain)
[![AKS](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/aks.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/aks.yml?query=branch%3Amain)
[![EKS](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/eks.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/eks.yml?query=branch%3Amain)
[![GKE](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/gke.yml/badge.svg?query=branch%3Amain)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/gke.yml?query=branch%3Amain)

## About
The [tyk-k8s-demo](https://github.com/TykTechnologies/tyk-k8s-demo) repository allows you to start up an entire Tyk Stack
with all its dependencies as well as other tools that can integrate with Tyk.
The repository will spin up everything in Kubernetes using `helm` and bash magic
to get you started.

## Purpose
Minimize the amount of effort needed to start up the Tyk infrastructure and
show examples of how Tyk can be set up in k8s using different deployment
architectures as well as different integrations.

## Prerequisites

### Required Packages

You will need the following tools to be able to run this project.
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) - CLI tool for controlling Kubernetes clusters
- [Helm](https://helm.sh/docs/intro/install/) - Helps manage Kubernetes applications through Helm charts
- [jq](https://stedolan.github.io/jq/download/) - CLI for working with JSON output and manipulating it
- [git](https://git-scm.com/downloads) - CLI used to obtain the project from GitHub
- [Terraform](https://www.terraform.io/) (only when using `--cloud` flag)

Tested on Linux/Unix based systems

### License Requirements
- **Tyk OSS**: No license required as it is open-source.
- **Licensed Products**: Sign up [here](https://tyk.io/sign-up)

#### How to use the license key

Once you obtained the license key, create a `.env` file using the [example provided](https://github.com/TykTechnologies/tyk-k8s-demo/blob/main/.env.example) and update it with your licenses as follows:

```bash
git clone https://github.com/TykTechnologies/tyk-k8s-demo.git
cd tyk-k8s-demo
cp .env.example .env
```

Depending on the deployments you would like to install set values of the `LICENSE`, `MDCB_LICENSE`, `PORTAL_LICENSE`
`OPERATOR_LICENSE`, inside the `.env` file.

### Minikube
If you are deploying this demo on [Minikube](https://minikube.sigs.k8s.io/docs/start),
you will need to enable the [ingress addon](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/#enable-the-ingress-controller).
You can do so by running the following commands:

```bash
minikube start
minikube addons enable ingress
```

## Quick Start
```bash
./up.sh --deployments portal,operator-httpbin tyk-stack
```
This quick start command will start up the entire Tyk stack along with the
Tyk Enterprise Portal, Tyk Operator, and httpbin CRD example.

## Possible deployments
- `tyk-stack`: A comprehensive Tyk Self Managed setup for a single region
- `tyk-cp`: Tyk control plane in a multi-region Tyk deployment.
- `tyk-dp`: Data plane of hybrid gateways that connect to either Tyk Cloud or a Tyk Control Plane, facilitating scalable deployments.
- `tyk-gateway`: Open Source Software (OSS) version of Tyk, self-managed and suitable for single-region deployments

## Dependencies Options
### Redis Options
- `redis`: Bitnami Redis deployment
- `redis-cluster`: Bitnami Redis Cluster deployment
- `redis-sentinel`: Bitnami Redis Sentinel deployment

### Storage Options
- `mongo`: [Bitnami Mongo](https://artifacthub.io/packages/helm/bitnami/mongodb) database deployment as a Tyk backend
- `postgres`: [Bitnami Postgres](https://artifacthub.io/packages/helm/bitnami/postgresql) database deployment as a Tyk backend

### Supplementary Deployments
Please see this [page](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/docs/FEATURES_MATRIX.md) for Tyk deployments compatibility charts.
- [cert-manager](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/cert-manager): deploys cert-manager.
- [datadog](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/datadog): deploys Datadog agent
	and starts up Tyk Pump to push analytics data from the Tyk platform to Datadog. It will also create a Datadog dashboard
	for you to view the analytics.
- [elasticsearch](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/elasticsearch): deploys
	Elasticsearch and starts up Tyk pump to push analytics data from the Tyk platform to Elasticsearch.
	- [elasticsearch-kibana](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/elasticsearch-kibana): deploys the Elasticsearch deployment as well as a Kibana deployment and creates a Kibana dashboard for you to view the analytics.
- [Jaeger](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/jaeger): deploys the Jaeger operator, a Jaeger instance, and the OpenTelemetry collector and configures the Tyk deployment to send telemetry data to Jaeger through the OpenTelemetry collector.
- [k6](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/k6): deploys a Grafana K6 Operator.
	- [k6-slo-traffic](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/k6-slo-traffic): deploys a k6 CRD to generate a load of traffic to seed analytics data.
- [keycloak](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/keycloak): deploys the Keycloak Operator and a Keycloak instance.
	- [keycloak-dcr](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/keycloak-dcr): starts up a Keycloak Dynamic Client Registration example.
	- [keycloak-jwt](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/keycloak-jwt): starts up a Keycloak JWT Authentication example with Tyk.
	- [keycloak-sso](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/keycloak-sso): starts up a Keycloak SSO example with the Tyk Dashboard.
- [newrelic](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/newrelic): deploys New Relic and starts up a Tyk Pump to push analytics data from the Tyk platform to New Relic.
- [opa](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/opa): enables Open Policy Agent to allow for Dashboard APIs governance.
- [opensearch](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/opensearch): deploys OpenSearch and starts up Tyk Pump to push analytics data from the Tyk platform to OpenSearch.
- [operator](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/operator): deploys the [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency [cert-manager](https://github.com/jetstack/cert-manager).
	- [operator-federation](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/operator-federation): starts up Federation v1 API examples using the tyk-operator.
	- [operator-graphql](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/operator-graphql): starts up GraphQL API examples using the tyk-operator.
	- [operator-httpbin](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/operator-httpbin): starts up an API examples using the tyk-operator.
	- [operator-jwt-hmac](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/operator-jwt-hmac): starts up API examples using the tyk-operator to demonstrate JWT HMAC auth.
	- [operator-udg](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/operator-udg): starts up Universal Data Graph API examples using the tyk-operator.
- [portal](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/portal): deploys the [Tyk Enterprise Developer Portal](https://tyk.io/docs/tyk-developer-portal/tyk-enterprise-developer-portal/) as well as its dependency PostgreSQL.
- [prometheus](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/prometheus): deploys Prometheus and starts up Tyk Pump to push analytics data from the Tyk platform to Prometheus.
	- [prometheus-grafana](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/prometheus-grafana): deploys the Prometheus deployment as well as a Grafana deployment and creates a Grafana dashboard for you to view the analytics.
- [vault](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/deployments/vault): deploys Vault Operator and a Vault instance.

If you are running a POC and would like an example of how to integrate a
specific tool, you are welcome to submit a [feature request](https://github.com/TykTechnologies/tyk-k8s-demo/issues/new/choose)

### Example
```bash
./up.sh \
  --storage postgres \
  --deployments prometheus-grafana,k6-slo-traffic \
  tyk-stack
```

The deployment process takes approximately 10 minutes, as the installation is sequential and some dependencies take
time to initialize. Once the installation is complete, the script will output a list of all the services that were
started, along with instructions on how to access them. Afterward, the k6 job will begin running in the background,
generating traffic for 15 minutes. To monitor live traffic, you can use the credentials provided by the script to
access Grafana or the Tyk Dashboard

## Usage

### Start Tyk deployment
Create and start up the deployments

```bash
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
  -s, --storage         enum     database the tyk stack will use. This option can be set 'mongo' (amd only) and defaults to 'postgres'
  -d, --deployments     string   comma separated list of deployments to launch
  -c, --cloud           enum     stand up k8s infrastructure in 'aws', 'gcp' or 'azure'. This will require Terraform and the CLIs associate with the cloud of choice
  -l, --ssl             bool     enable ssl on deployments
```

### Stop Tyk deployment
Shutdown deployment

```bash
Usage:
  ./down.sh [flags]

Flags:
  -v, --verbose         bool     set log level to debug
  -n, --namespace       string   namespace the tyk stack will be installed in, defaults to 'tyk'
  -p, --ports           bool     disconnect port connections only
  -c, --cloud           enum     tear down k8s cluster stood up
```

For more information, please see the [docs' folder](docs).
