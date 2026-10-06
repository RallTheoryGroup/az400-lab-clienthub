# InfraCore

**Division:** RallTheory Managed IT
**Chapters:** 15
**Stack:** Bicep + Terraform + Docker

## Description

InfraCore is the infrastructure deployment platform for RallTheory Managed IT. It provides IaC templates and container definitions used to demonstrate container scanning, IaC policy validation, and compliance-as-code.

## Contents

These directories initially contain placeholders, not runnable fixtures. Follow `ch15/ch15_Lab_Guide.md` from the repository root to create the dependency-free Node image and static Bicep/Terraform examples. The lab compiles Bicep to ARM before policy scanning and does not deploy infrastructure.

```
infracore/
├── bicep/       # Azure Bicep templates
├── terraform/   # Terraform configurations
└── docker/      # Dockerfiles for container scanning exercises
```
