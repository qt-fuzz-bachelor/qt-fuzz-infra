# Fuzzing Infrastructure in OpenStack

This directory contains the infrastructure-as-code (IaC) used to provision and manage the environment required to run the Qt HTTP Server fuzzer.

The infrastructure is deployed on OpenStack and defined using Terraform / OpenTofu, enabling reproducible, auditable, and automated setup of compute, networking, and storage resources needed for fuzzing at scale.

The goal of this infrastructure is to provide:
- Isolated and reproducible fuzzing environments
- Easy scaling of fuzzing workers
- Consistent configuration across deployments
- Safe teardown and recreation of resources

---

## Infrastructure Overview

The IaC provisions the following components (exact resources may vary by configuration):

- **Compute instances**
  - One or more virtual machines used as fuzzing workers
  - Optional controller or coordinator node
- **Networking**
  - Private network(s) for fuzzing workloads
  - Optional floating IPs for SSH access
  - Security groups with restricted ingress
- **Storage**
  - Boot volumes for fuzzing nodes
  - Optional persistent volumes for crash artifacts and logs
- **Access**
  - SSH key pairs
  - Cloud-init or provisioning scripts for initial setup

All resources are managed declaratively and can be recreated from scratch using the same configuration.
