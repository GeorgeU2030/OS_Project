<#
.SYNOPSIS
This script provides a menu-driven tool for datacenter operations.

.DESCRIPTION
The tool provides the following options:
1. Display the five processes that are consuming the most CPU
2. Deploy the filesystems or disks connected to the machine
3. Display the name and size of the largest stored file
4. Display the amount of free memory and amount of swap space in use
5. Display the number of currently active network connections
6. Exit the tool

#>

function Menu {
    Clear-Host
    Write-Host "==========================="
    Write-Host " Datacenter Tool"
    Write-Host "==========================="
    Write-Host "1. Display the five processes that are Consuming the Most CPU"
    Write-Host "2. Deploy the filesystems or Disks Connected to the Machine"
    Write-Host "3. Display the name and size of the Largest Stored file"
    Write-Host "4. Amount of free memory and amount of Swap Space in use"
    Write-Host "5. Number of currently active Network Connections"
    Write-Host "6. Exit"
}

# First Function - Display the five processes that are Consuming the Most CPU

function TopFiveCPU {
    # We get proccess, sort by CPU, select the first 5, format the output
    Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 5 | Format-Table -Property Id, ProcessName, CPU
}

# Second Function - Deploy the filesystems or Disks Connected to the Machine

function DeployFilesystems {
    $output = Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free, @{Name="Free (MB)";Expression={$_.Free/1MB}}, @{Name="Used (MB)";Expression={$_.Used/1MB}}, @{Name="Size";Expression={$_.Used + $_.Free}}, @{Name="Size (GB)";Expression={($_.Used + $_.Free)/1GB}}
    Write-Host ($output | Out-String)
}

# Third Function - Display the name and size of the Largest Stored file

function LargestStoredFile {
    param (
        [string]$path 
    )
    Write-Progress -Activity "Searching for the Largest Stored File" -Status "Please Wait..."
    Get-ChildItem -Path $path -Recurse -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer } | Sort-Object -Property Length -Descending | Select-Object -First 1 | Format-Table -Property FullName, Length
    Write-Progress -Activity "Searching for the Largest Stored File" -Completed
}

# Fourth Function - Amount of free memory and amount of Swap Space in use

function MemoryandSwap {
    $memory = Get-WmiObject -Class Win32_OperatingSystem
    $swap = Get-WmiObject -Class Win32_PageFileUsage

    Write-Host "Free Memory: $($memory.FreePhysicalMemory * 1KB) Bytes"
    Write-Host "Swap Space: $($swap.AllocatedBaseSize * 1MB) Bytes ($("{0:N2}" -f ($swap.CurrentUsage / $swap.AllocatedBaseSize * 100))%)"
}

# Fifth Function - Number of currently active Network Connections

function ActiveNetworkConnections {
   Write-Host "`nNumber of Connections:" (Get-NetTCPConnection -State Established).Count 
}

# Main Loop - Menu

do {
    Menu

    # Read the user's option
    $option = Read-Host "Select an Option"

    switch ($option) {
        1 {
            # Call the function to display the top five processes consuming the most CPU
            TopFiveCPU
        }
        2 {
            # Call the function to deploy the filesystems or disks connected to the machine
            DeployFilesystems
        }
        3 {
            # Call the function to display the name and size of the largest stored file
            $path = Read-Host "Enter the Path to Search"
            LargestStoredFile -path $path
        }
        4 {
            # Call the function to display the amount of free memory and amount of swap space in use
            Write-Host "`n"
            MemoryandSwap
            Write-Host "`n"
        }
        5 {
            # Call the function to display the number of currently active network connections
            ActiveNetworkConnections
            Write-Host "`n"
        }
        6 {
            # Exit the tool
            Write-Host "Exiting... GoodBye ;)"
        }
        default {
            # Invalid option - Default
            Write-Host "`nInvalid Option, Please Enter a Valid Option ;)`n"
        }
    }

    if ($option -ne "6") {
        # Wait for the user to press Enter to continue
        Write-Host "Presione Enter para continuar..."
        Read-Host
    }

# Loop until the user selects option 6 to exit
} while ($option -ne "6")