# tyk-k8s-poc
<!-- Tell other people why your project is useful, what they can do with your project, and how they can use it.
As explained in GitHub it typically includes information on:
1. What the project does
2. Why the project is useful
3. How users can get started with the project
4. Where users can get help with your project
5. Who maintains and contributes to the project
For more details check GitHub [doc](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)

PLEASE CHANGE THIS FILE NAME TO BE "README.md" so GitHub can automatically surface it to repository visitors.
-->

## About
Will allow you to deploy the entire Tyk stack for POC on helm and docker.
  
## Purpose
Minimizing the amount of effort you need to stand up you Tyk infra.
  
## Getting started  

#### Prerequisites
- Helm

#### Possible deployments
- `tyk-pro`: Tyk pro self-managed single region
- `tyk-cp`: Tyk pro self-managed multi region control plane
- `tyk-edge`: Tyk hybrid edges
- `tyk-gateway`: Tyk oss self-managed single region

#### Flavors
- `vanilla`: Vanilla k8s
- `os`: OpenShift

#### Add ons
- `operator`: Tyk operator
- `enterprise-portal`: Tyk enterprise portal
