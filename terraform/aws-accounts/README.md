# AWS Accounts folder

```text
├── cloud-platform-ephemeral-test       # Account Name
│   ├── bootstrap                       # Creation of terraform state backend.
│   ├── cloud-platform                  # Holding kops/bastion/route53, workspaces for individual clusters.
│   ├── cloud-platform-account          # AWS Account specific configuration.
│   ├── cloud-platform-components       # K8S components. Workspaces for individual clusters
│   └── cloud-platform-network          # VPC creation. Workspaces for individual clusters
├── cloud-platform
│   ├── bootstrap
│   ├── cloud-platform
│   ├── cloud-platform-account
│   ├── cloud-platform-components
│   └── cloud-platform-network
└── README.md                           # This README

```