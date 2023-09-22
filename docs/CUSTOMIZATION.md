# Customization
This library can also act as a guide to help you get set up with Tyk. If you just want to know how to set up a specific
tool with Tyk, you can run the library with the `--dry-run` and `--verbose` flags. This will output all the commands that
the library will run to stand up any installation. This can be helpful for debugging as well as figuring out what
configuration options are required to set these tools up.

Furthermore, you can also add any Tyk environment variables to your `.env` file and those variables will be mapped to
their respective Tyk deployments.

Example:
```
...
TYK_MDCB_SYNCWORKER_ENABLED=true
TYK_MDCB_SYNCWORKER_HASHKEYS=true
TYK_GW_SLAVEOPTIONS_SYNCHRONISERENABLED=true
```

## Variables
The script has defaults for minimal settings in [this env file](https://github.com/TykTechnologies/tyk-k8s-demo/blob/v2/.env.example),
and it will give errors if something is missing.
You can also add or change any Tyk environments variables in the `.env` file,
and they will be mapped to the respective `extraEnvs` section in the helm charts.

| Variable                    |        Default        | Comments                                                                                                        |
|-----------------------------|:---------------------:|-----------------------------------------------------------------------------------------------------------------|
| DASHBOARD_VERSION           |        `v5.0`         | Dashboard version                                                                                               |
| GATEWAY_VERSION             |        `v5.0`         | Gateway version                                                                                                 |
| MDCB_VERSION                |        `v2.1`         | MDCB version                                                                                                    |
| PUMP_VERSION                |        `v1.7`         | Pump version                                                                                                    |
| PORTAL_VERSION              |        `v1.2`         | Portal version                                                                                                  |
| TYK_HELM_CHART_PATH         |      `tyk-helm`       | Path to charts, can be a local directory or a helm repo                                                         |
| TYKUSERNAME                    | `default@example.com` | Default password for all the services deployed                                                                  |
| PASSWORD                    |  `topsecretpassword`  | Default password for all the services deployed                                                                  |
| LICENSE                     |                       | Dashboard license                                                                                               |
| MDCB_LICENSE                |                       | MDCB license                                                                                                    |
| PORTAL_LICENSE              |                       | Portal license                                                                                                  |
| TYK_WORKER_CONNECTIONSTRING |                       | MDCB URL for worker connection                                                                                  |
| TYK_WORKER_ORGID            |                       | Org ID of dashboard user                                                                                        |
| TYK_WORKER_AUTHTOKEN        |                       | Auth token of dashboard user                                                                                    |
| TYK_WORKER_USESSL           |        `true`         | Set to `true` when the MDCB is serving on a TLS connection                                                      |
| TYK_WORKER_SHARDING_ENABLED |        `false`        | Set to `true` to enable API Sharding                                                                            |
| TYK_WORKER_SHARDING_TAGS    |                       | API Gateway segmentation tags                                                                                   |
| TYK_WORKER_GW_PORT          |        `8081`         | Set the gateway service port to use                                                                             |
| DATADOG_APIKEY              |                       | Datadog API key                                                                                                 |
| DATADOG_APPKEY              |                       | Datadog Application key. This is used to create a dashboard and create a pipeline for the Tyk logs              |
| DATADOG_SITE                |    `datadoghq.com`    | Datadog site. Change to `datadoghq.eu` if using the european site                                               |
| GCP_PROJECT                 |                       | The GCP project for terraform authentication on GCP                                                             |
| CLUSTER_LOCATION            |                       | Cluster location that will be created on AKS, EKS, or GKE                                                       |
| CLUSTER_MACHINE_TYPE        |                       | Machine type for the cluster that will be created on AKS, EKS, or GKE                                           |
| CLUSTER_NODE_COUNT          |                       | Number of nodes for the cluster that will be created on AKS, EKS, or GKE                                        |
| INGRESS_CLASSNAME           |        `nginx`        | The ingress classname to be used to associate the k8s ingress objects with the ingress controller/load balancer |
