// shared.bicep
// Deploys shared resources used across all chapters:
//   - Log Analytics workspace (free tier)
//   - Application Insights
//   - Azure Container Registry (Basic SKU)
//   - Azure Key Vault (Standard)
//
// Usage:
//   az deployment group create -g rg-ralltheory-shared --template-file shared.bicep

param location string = resourceGroup().location
param uniqueSuffix string = uniqueString(resourceGroup().id)

// ─── Log Analytics Workspace ────────────────────────────────────────────
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'la-ralltheory-${uniqueSuffix}'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
  tags: {
    project: 'RallTheoryGroup'
  }
}

// ─── Application Insights ───────────────────────────────────────────────
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'ai-ralltheory-${uniqueSuffix}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
  }
  tags: {
    project: 'RallTheoryGroup'
  }
}

// ─── Azure Container Registry ───────────────────────────────────────────
resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: 'acrralltheory${uniqueSuffix}'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: false
  }
  tags: {
    project: 'RallTheoryGroup'
  }
}

// ─── Azure Key Vault ────────────────────────────────────────────────────
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv-ralltheory-${uniqueSuffix}'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
  }
  tags: {
    project: 'RallTheoryGroup'
  }
}

// ─── Outputs ────────────────────────────────────────────────────────────
output logAnalyticsId string = logAnalytics.id
output appInsightsKey string = appInsights.properties.InstrumentationKey
output acrLoginServer string = acr.properties.loginServer
output keyVaultUri string = keyVault.properties.vaultUri
