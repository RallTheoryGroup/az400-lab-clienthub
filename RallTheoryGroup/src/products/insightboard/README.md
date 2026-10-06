# InsightBoard

**Division:** RallTheory Products
**Chapters:** 7, 8, 9
**Stack:** .NET Class Library + xUnit

## Description

InsightBoard is an analytics SaaS platform by RallTheory Products. It demonstrates package feeds, NuGet versioning, unit testing strategies, and YAML CI/CD pipelines.

## Lab starting state

This directory is a scaffold: `src/.gitkeep` is not a .NET project. Create the `net8.0` library in [Lab 7](../../../../ch7/ch7_Lab_Guide.md), then add the seven-test suite, MSBuild coverage integration, and dependency locks in [Lab 8](../../../../ch8/ch8_Lab_Guide.md).

After completing those steps, run from the **book repository root**:

```bash
dotnet restore RallTheoryGroup/src/products/insightboard/src/InsightBoard.Tests/InsightBoard.Tests.csproj --locked-mode
dotnet test RallTheoryGroup/src/products/insightboard/src/InsightBoard.Tests/InsightBoard.Tests.csproj --configuration Release --no-restore
```

[Lab 9](../../../../ch9/ch9_Lab_Guide.md) transfers the built candidate through testing and protected delivery to an isolated filesystem feed. It does not deploy a web application; no API host is supplied here. Workflows belong in the Git repository root's `.github/workflows`, not this directory. See the lab guides for permissions, expected results, cleanup, and unexecuted validation requirements.
