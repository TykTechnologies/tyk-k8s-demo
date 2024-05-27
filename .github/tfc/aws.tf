terraform {
	cloud {
		organization = "tyk-k8s-demo"

		workspaces {
			name = "eks"
		}
	}
}
