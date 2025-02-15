# This is the file that is supplied to powershell dsc so it knows what to do

Configuration Setup
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Node localhost
    {
        Script Install
        {
            GetScript = { return; }            
            TestScript = { return $false; }
            SetScript = 
            {
                $ErrorActionPreference = 'Stop';

                # This sets up prometheus windows node exporter on the node. 
                # Note: there is a second step needed for prometheus to actually pull from the node exporter by adding this nodes ip and port to the node exporter endpoint in k8s.
                #       This will have to happen in another place that keeps that list maintained based on the windows nodes available in aks
                function Install-Windows-Exporter
                {
                # Ensureing admin right to install client
                if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
                    msiexec /i `
                        C:\PROGRA~1\WindowsPowerShell\Modules\aks_setup\dsc_resources\windows_exporter-0.18.1-amd64.msi`
                        LISTEN_PORT=9100 `
                        ENABLED_COLLECTORS=cpu,cs,cache,container,logical_disk,memory,net,os,service,system,tcp
                }
                
                Install-Windows-Exporter;
            }
        }
    }
}
