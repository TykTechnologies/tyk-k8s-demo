# Clusters
You can get the library to create demo clusters for you on AWS, GCP, or Azure. That can be set using the `--cloud` flag
and requires the respective cloud CLI to be installed and authorized on your system. You will also need to specify the
`CLUSTER_LOCATION`, `CLUSTER_MACHINE_TYPE`, `CLUSTER_NODE_COUNT` and `GCP_PROJECT` (for GCP only) parameters in the .env file.

You can find examples of .env files under each of the `src/clouds` folders:
- [AWS](src/clouds/aws/.env.example)
- [GCP](src/clouds/gcp/.env.example)
- [Azure](src/clouds/azure/.env.example)

For more information about cloud CLIs:
- AWS:
	- [aws](https://aws.amazon.com/cli/)
- GCP:
	- [gcloud](https://cloud.google.com/sdk/gcloud)
	- `GOOGLE_APPLICATION_CREDENTIALS` environment variable per [google's documentation](https://cloud.google.com/docs/authentication/application-default-credentials)
- Azure:
	- [az](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
