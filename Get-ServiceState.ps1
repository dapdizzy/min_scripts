function Get-ServiceState($serviceName, $computername)
{
    $service = Get-WmiObject Win32_Service -ComputerName $computername -Filter "name=""$serviceName""" -Outvariable out -ErrorAction SilentlyContinue -Verbose
    if ($service -eq $null)
    {
        return "Unavailable, Unavailable"
        #throw "Service $serviceName does not exist"
    }

    # $service | Format-List *

    "$($service.State), $($service.StartMode)"
}

Get-ServiceState $args[0] $args[1]