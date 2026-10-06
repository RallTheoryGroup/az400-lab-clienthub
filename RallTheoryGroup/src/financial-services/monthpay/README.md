# MonthPay

**Division:** RallTheory Financial Services
**Chapters:** 14
**Stack:** .NET Web App

## Description

MonthPay is the payroll and monthly payment processing app for RallTheory Financial Services. It serves as the target application for SAST, SCA, and security scanning exercises.

## Quick Start

The repository contains a scaffold directory, not a prebuilt .NET application. Follow `ch14/ch14_Lab_Guide.md` from the repository root to create `src/MonthPay/MonthPay.csproj`, configure scanning, and prove the protected-branch gate.

Do not deploy the deliberately vulnerable dependency used for the negative scan. Upgrade it and repeat the scan before retaining the completed application. The lab requires no Azure registry or admin credential.
