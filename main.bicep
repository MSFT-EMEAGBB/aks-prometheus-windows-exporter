resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-11-01' existing = {
  name: ''
}

resource vmss_extension 'Microsoft.Compute/virtualMachineScaleSets/extensions@2021-11-01' = {
  name: 'string'
  parent: vmss
  properties: {
    autoUpgradeMinorVersion: false
    enableAutomaticUpgrade: true
    forceUpdateTag: 'string'
    protectedSettings: {}
    provisionAfterExtensions: [
      'string'
    ]
    publisher: 'string'
    settings: {}
    suppressFailures: true
    type: 'DSC'
    typeHandlerVersion: 'string'
  }
}
