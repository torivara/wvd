module avd1 'BicepModules/1. Deploy-Modules.bicep' = {
  name: 'deployAvd1'
  scope: subscription()
  params: {
    resourceGroupPrefix: 'tia-avddemo1'
    vnetaddressPrefix: '10.0.0.0/16'
    subnetPrefix: '10.0.0.0/24'
  }

}

module avd2 'BicepModules/1. Deploy-Modules.bicep' = {
  name: 'deployAvd2'
  scope: subscription()
  params: {
    resourceGroupPrefix: 'tia-avddemo2'
    vnetaddressPrefix: '10.1.0.0/16'
    subnetPrefix: '10.1.0.0/24'
  }

}

module avd3 'BicepModules/1. Deploy-Modules.bicep' = {
  name: 'deployAvd3'
  scope: subscription()
  params: {
    resourceGroupPrefix: 'tia-avddemo3'
    vnetaddressPrefix: '10.2.0.0/16'
    subnetPrefix: '10.0.2.0/24'
  }

}

module avd4 'BicepModules/1. Deploy-Modules.bicep' = {
  name: 'deployAvd4'
  scope: subscription()
  params: {
    resourceGroupPrefix: 'tia-avddemo4'
    vnetaddressPrefix: '10.3.0.0/16'
    subnetPrefix: '10.3.0.0/24'
  }

}
