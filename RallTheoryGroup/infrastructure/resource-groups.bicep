// resource-groups.bicep
// Deploys all RallTheory Group resource groups in a single subscription-level deployment.
// Usage:
//   az deployment sub create --location eastus --template-file resource-groups.bicep

targetScope = 'subscription'

param location string = 'eastus'

var resourceGroups = [
  'rg-ralltheory-shared'
  'rg-ralltheory-digital'
  'rg-ralltheory-financial'
  'rg-ralltheory-products'
  'rg-ralltheory-infra'
]

resource rgs 'Microsoft.Resources/resourceGroups@2024-03-01' = [
  for rgName in resourceGroups: {
    name: rgName
    location: location
    tags: {
      project: 'RallTheoryGroup'
      environment: 'demo'
      book: 'AZ-400 Exam Guide'
    }
  }
]
