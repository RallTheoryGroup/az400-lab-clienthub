# LedgerFlow

**Division:** RallTheory Financial Services
**Chapters:** 12, 13
**Stack:** .NET Web API

## Description

LedgerFlow is a reconciliation and reporting platform for RallTheory Financial Services. It demonstrates secure pipeline identities (OIDC/workload identity federation) and Azure Key Vault integration.

## Quick Start

```bash
cd RallTheoryGroup/src/financial-services/ledgerflow/src/LedgerFlow
dotnet restore
dotnet run --no-launch-profile --urls http://localhost:5082
```

Use .NET SDK 8. Check `http://localhost:5082/health` for HTTP 200 and `/version` for `LedgerFlow` version `1.0.0`. This minimal API is a deployment fixture: it does not connect to a database, process financial records, or expose secret values. Chapter 12 proves deployment identity; Chapter 13 proves vault access separately. No additional NuGet packages are required.
