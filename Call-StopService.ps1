Add-Type -AssemblyName system.ServiceProcess

function Call-StopService($serviceName, $computername)
{
    $service = Get-WmiObject Win32_Service -ComputerName $computername -Filter "name=""$serviceName""" -Outvariable out -Verbose
    if ($service -eq $null)
    {
        throw "Service $serviceName does not exist"
    }
    $rv = 0
    if ($service.State -ne [System.ServiceProcess.ServiceControllerStatus]::Stopped)
    {
        $rv = $service.StopService().ReturnValue
    }
    $rv
}

Call-StopService $args[0] $args[1]