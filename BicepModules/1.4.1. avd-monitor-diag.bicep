//Define diagnostic setting  parameters
param logAnalyticsWorkspaceID string
param hostpoolName string
param workspaceName string

//Concat diagnostic setting names
var hostpoolDiagName = '${hostpoolName}/Microsoft.Insights/hostpool-diag'
var workspaceDiagName = '${workspaceName}/Microsoft.Insights/workspacepool-diag'

resource hostpool 'Microsoft.DesktopVirtualization/hostPools@2021-09-03-preview' existing = {
  name: hostpoolName
}

resource workspace 'Microsoft.DesktopVirtualization/workspaces@2021-09-03-preview' existing = {
  name: workspaceName
}

//Create diagnostic settings for AVD Objects
resource avdhpds 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name : hostpoolDiagName
  scope: hostpool
  properties : {
    workspaceId: logAnalyticsWorkspaceID
    logs : [
      {
      category : 'Checkpoint'
      enabled: true
      }
      {
        category : 'Error'
        enabled: true
      }
      {
        category : 'Management'
        enabled: true
      }
      {
        category : 'Connection'
        enabled: true
      }      
      {
        category : 'HostRegistration'
        enabled: true
      }   
    ]
  }
}

resource avdwsds 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name : workspaceDiagName
  scope: workspace
  properties : {
    workspaceId: logAnalyticsWorkspaceID
    logs : [
      {
      category : 'Checkpoint'
      enabled: true
      }
      {
        category : 'Error'
        enabled: true
      }
      {
        category : 'Management'
        enabled: true
      }
      {
        category : 'Feed'
        enabled: true
      }      
    ]
  }
}
