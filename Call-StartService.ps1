Add-Type -AssemblyName system.ServiceProcess

function Call-StartService($serviceName, $computername)
{
    $service = Get-WmiObject Win32_Service -ComputerName $computername -Filter "name=""$serviceName""" -Outvariable out -Verbose
    if ($service -eq $null)
    {
        throw "Service $serviceName does not exist"
    }
    $rv = 0
    if ($service.State -ne [System.ServiceProcess.ServiceControllerStatus]::Running)
    {
        $rv = $service.StartService().ReturnValue
    }
    $rv
}

Call-StartService $args[0] $args[1]