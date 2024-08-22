# Clusters
You can get the repository to create demo clusters for you on AWS, GCP, or Azure. That can be set using the `--cloud` flag
and requires the respective cloud CLI to be installed and authorized on your system. You will also need to specify the
`CLUSTER_LOCATION`, `CLUSTER_MACHINE_TYPE`, `CLUSTER_NODE_COUNT`, and `GCP_PROJECT` (for GCP only) parameters in the .env file.

You can find examples of .env files here:
- [AWS](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/clouds/aws/.env.example)
- [GCP](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/clouds/gcp/.env.example)
- [Azure](https://github.com/TykTechnologies/tyk-k8s-demo/tree/main/src/clouds/azure/.env.example)

For more information about cloud CLIs:
- AWS:
	- [aws](https://aws.amazon.com/cli/)
- GCP:
	- [gcloud](https://cloud.google.com/sdk/gcloud)
	- `GOOGLE_APPLICATION_CREDENTIALS` environment variable per [documentation from Google](https://cloud.google.com/docs/authentication/application-default-credentials)
- Azure:
	- [az](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
