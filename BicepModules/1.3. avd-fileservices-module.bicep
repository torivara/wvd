//Define Azure Files parmeters
param storageAccountlocation string = 'westeurope'
@maxLength(7)
param storageAccountName string
param storageAccountKind string
param storageAccountGlobalRedundancy string = 'Standard_LRS'
param fileshareFolderName string = 'profilecontainers'
//Concat FileShare
var filesharelocation = '${sa.name}/default/${fileshareFolderName}'
var storageAccountName_var = '${storageAccountName}${uniqueString(resourceGroup().id)}-sa'

//Create Storage account
resource sa 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name : storageAccountName_var
  location : storageAccountlocation
  kind : storageAccountKind
  sku: {
    name: storageAccountGlobalRedundancy
  }
}

//Create FileShare
resource fs 'Microsoft.Storage/storageAccounts/fileServices/shares@2020-08-01-preview' = {
  name :  filesharelocation
}
