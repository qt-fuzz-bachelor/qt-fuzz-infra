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

## Configure persistent volumes

After creating the infrastructure, you need to mount and (optionally) format the volumes.

### On Linux

#### **1. Find the disk**

```bash
lsblk
```
Look for an unmounted device (e.g. `/dev/vdb`).

#### **2. Check if it already has a filesystem**

```bash
sudo blkid /dev/vdb
```
- No output → empty disk (continue to step 3)
- Has a TYPE → skip formatting

#### **3. Create filesystem (only if empty)**
```bash
sudo mkfs.ext4 /dev/vdb
```

#### **4. Mount the volume**
```bash
sudo mkdir -p /mnt/data
sudo mount /dev/vdb /mnt/data
cd /mnt/data
```

Set owner to user:
```bash
sudo chown -R ubuntu:ubuntu /mnt/data
```

#### **5. (Optional) Persist after reboot**
```bash
sudo blkid /dev/vdb
sudo vi /etc/fstab
```

Add:
```
UUID=<uuid> /mnt/data ext4 defaults,nofail 0 2
```

Apply:
```bash
sudo mount -a
```
