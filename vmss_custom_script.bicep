param scriptLocation string
param winvmssname string

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-11-01' existing = {
  name: winvmssname
}

resource vmss_extension 'Microsoft.Compute/virtualMachineScaleSets/extensions@2021-11-01' = {
  name: 'windows_exporter_cs'
  parent: vmss
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Compute'
    settings: {
      fileUris: [ 
        scriptLocation
      ]
    }
    protectedSettings: {
      commandToExecute: 'powershell.exe install-metrics-explorer.ps1' 
    }

    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'

    provisionAfterExtensions: [
      'vmssCSE'
    ]
  }
}
