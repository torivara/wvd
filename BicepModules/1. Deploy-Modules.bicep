targetScope = 'subscription'

//Define AVD deployment parameters
param resourceGroupPrefrix string = 'tia-avddemo-'
param hostpoolName string = 'myBicepHostpool'
param hostpoolFriendlyName string = 'My Bicep deployed Hostpool'
param appgroupName string = 'myBicepAppGroup'
param appgroupNameFriendlyName string = 'My Bicep deployed Appgroup'
param workspaceName string = 'myBicepWorkspace'
param workspaceNameFriendlyName string = 'My Bicep deployed Workspace'
param preferredAppGroupType string = 'Desktop'
param avdbackplanelocation string = 'norwayeast'
param hostPoolType string = 'pooled'
param loadBalancerType string = 'BreadthFirst'
param logAnalyticsWorkspaceName string = 'tia-avdmonitor-la'

//Define Networking deployment parameters
param vnetName string = 'tia-avddemo-vnet'
param vnetaddressPrefix string ='10.0.0.0/15'
param subnetPrefix string = '10.0.1.0/24'
param vnetLocation string = 'norwayeast'
param subnetName string = 'hostpool1-subnet'

//Define Azure Files deployment parameters
param storageAccountlocation string = 'norwayeast'
param storageAccountName string = 'bicepsa'
param storageAccountkind string = 'FileStorage'
param storageAccountGlobalRedundancy string = 'Premium_LRS'
param fileshareFolderName string = 'profilecontainers'

//Create Resource Groups
resource rgavd 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name : '${resourceGroupPrefrix}backplane-rg'
  location : 'norwayeast'
}
resource rgnetw 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name : '${resourceGroupPrefrix}network-rg'
  location : 'norwayeast'
}
resource rgfs 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name : '${resourceGroupPrefrix}fileservices-rg'
  location : 'norwayeast'
}
resource rdmon 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name :'${resourceGroupPrefrix}monitor-rg'
  location : 'norwayeast'
}

//Create AVD backplane objects and configure Log Analytics Diagnostics Settings
module avdbackplane './1.1 avd-backplane-module.bicep' = {
  name: 'avdbackplane'
  scope: resourceGroup(rgavd.name)
  params: {
    hostpoolName: hostpoolName
    hostpoolFriendlyName: hostpoolFriendlyName
    appgroupName: appgroupName
    appgroupNameFriendlyName: appgroupNameFriendlyName
    workspaceName: workspaceName
    workspaceNameFriendlyName: workspaceNameFriendlyName
    preferredAppGroupType: preferredAppGroupType
    applicationgrouptype: preferredAppGroupType
    avdbackplanelocation: avdbackplanelocation
    hostPoolType: hostPoolType
    loadBalancerType: loadBalancerType
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    logAnalyticsResourceGroup : rdmon.name
    avdBackplaneResourceGroup : rgavd.name
  }
}

//Create AVD Netwerk and Subnet
module avdnetwork './1.2. avd-network-module.bicep' = {
  name: 'avdnetwork'
  scope: resourceGroup(rgnetw.name)
  params: {
    vnetName : vnetName
    vnetaddressPrefix : vnetaddressPrefix
    subnetPrefix : subnetPrefix
    vnetLocation : vnetLocation
    subnetName : subnetName
  }
}

//Create AVD Azure File Services and FileShare`
module avdFileServices './1.3. avd-fileservices-module.bicep' = {
  name: 'avdFileServices'
  scope: resourceGroup(rgfs.name)
  params: {
    storageAccountlocation : storageAccountlocation
    storageAccountName : storageAccountName
    storageAccountKind : storageAccountkind
    storageAccountGlobalRedundancy : storageAccountGlobalRedundancy
    fileshareFolderName : fileshareFolderName
  }
}
