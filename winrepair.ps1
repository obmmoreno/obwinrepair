do {
    Clear-Host
    Write-Host @" 
________                   __________          __                     .____    .____   _________  
\_____  \___  __ __________\______   \___.__._/  |_  ____   ______    |    |   |    |  \_   ___ \ 
 /   |   \  \/ // __ \_  __ \    |  _<   |  |\   __\/ __ \ /  ___/    |    |   |    |  /    \  \/ 
/    |    \   /\  ___/|  | \/    |   \\___  | |  | \  ___/ \___ \     |    |___|    |__\     \____
\_______  /\_/  \___  |__|  |______  // ____| |__|  \___  >____  > /\ |_______ \_______ \______  /
        \/          \/             \/ \/                \/     \/  \/         \/       \/      \/ 
"@ -ForegroundColor Gray
    Write-Host "Choose an option:" -ForegroundColor DarkCyan
    Write-Host @"
1. Release and Renew IP Address
2. Repair Windows (System File Checker and DISM)       /\_/\
3. Reset Print Spooler                                ( o.o )
4. Get Device Serial Number                            > ^ <
5. Run GPUpdate
6. Flush and Register DNS
7. Create Local User and Add to Administrators
8. Enable PSRemoting
9. Disable IPv6
10. Enable Remote Desktop
11. Set Firewall Profiles to Allow All
12. CheckDisk C:\
13. Download and Install Microsoft Visual C++ 2015-2022
14. Advanced IPScanner 
15. Imaging Software Fixes
16. Exit
"@ -ForegroundColor Magenta
  
    $choice = Read-Host "Enter the number of your choice"

    switch ($choice) {
        "1" {
            Write-Host "Releasing and Renewing IP Address..." -ForegroundColor Magenta
            ipconfig /release
            ipconfig /renew
            Write-Host "Operation completed. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "2" {
            Write-Host "Repairing Windows..." -ForegroundColor Magenta
            Write-Host "Running System File Checker (sfc /scannow)..." -ForegroundColor Magenta
            sfc /scannow
            Write-Host "Running DISM to repair Windows image..." -ForegroundColor Magenta
            DISM /Online /Cleanup-Image /RestoreHealth
            Write-Host "Repair completed. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "3" {
            Write-Host "Resetting Print Spooler..." -ForegroundColor Magenta
            Stop-Service -Name spooler -Force
            Start-Service -Name spooler
            Write-Host "Print Spooler has been reset. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "4" {
            Write-Host "Getting Device Serial Number..." -ForegroundColor Magenta
            Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber
            Write-Host "Operation completed. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "5" {
            Write-Host "Running GPUpdate..." -ForegroundColor Magenta
            gpupdate /force
            Write-Host "Group Policy Update completed. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "6" {
            Write-Host "Flushing and Registering DNS..." -ForegroundColor Magenta
            ipconfig /flushdns
            ipconfig /registerdns
            Write-Host "DNS operations completed. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "7" {
            Write-Host "Creating a Local User and Adding to Administrators..." -ForegroundColor Magenta
            $username = Read-Host "Enter the username for the new user"
            $password = Read-Host "Enter the password for the new user" -AsSecureString
            New-LocalUser -Name $username -Password $password -FullName $username -Description "Local user created via script"
            Add-LocalGroupMember -Group "Administrators" -Member $username
            Write-Host "User $username has been created and added to the Administrators group. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "8" {
            Write-Host "Enabling PSRemoting..." -ForegroundColor Magenta
            Enable-PSRemoting -Force
            Write-Host "PSRemoting has been enabled. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "9" {
            Write-Host "Disabling IPv6..." -ForegroundColor Magenta
            $adapters = Get-NetAdapter

foreach ($adapter in $adapters) {
    Write-Host "Disabling IPv6 on adapter: $($adapter.Name)" -ForegroundColor Magenta
    Disable-NetAdapterBinding -Name $adapter.Name -ComponentID "ms_tcpip6"
}
            Write-Host "IPv6 Disabled. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "10" {
            Write-Host "Enabling Remote Desktop..." -ForegroundColor Magenta
            Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
            Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
            Write-Host "Remote Desktop has been enabled. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "11" {
            Write-Host "Setting Firewall Profiles to Allow" -ForegroundColor Magenta
            Set-NetFirewallProfile -Profile Domain,Private,Public -DefaultInboundAction Allow
            Write-Host "Firewall configuration completed successfully. Press Enter to continue." -ForegroundColor Magenta
            Read-Host
        }
        "12" {
            Write-Host "Running CheckDisk for C:. A reboot will be required, can take up to 1 hour." -ForegroundColor Magenta
            chkdsk C: /r  
            Write-Host "Restart PC when its best. Press Enter to Continue." -ForegroundColor Magenta
            Read-Host     
        }
        "13" {
            Write-Host "Downloading C++" -ForegroundColor Magenta
            mkdir C:\obsoftware;Invoke-WebRequest https://aka.ms/vs/17/release/vc_redist.x64.exe -OutFile C:\obsoftware\c++.exe;Invoke-WebRequest https://aka.ms/vs/17/release/vc_redist.x86.exe -OutFile C:\obsoftware\C++x86.exe;C:\obsoftware\C++.exe;C:\obsoftware\C++x86.exe;Write-Host "Press Enter to Continue" -ForegroundColor Magenta;Read-Host
          
        }
        "14" {
            Invoke-RestMethod https://download.advanced-ip-scanner.com/download/files/Advanced_IP_Scanner_2.5.4594.1.exe -Outfile C:\ipscanner.exe; Start-Process C:\ipscanner.exe
            Write-Host "Press Enter to go back (this will delete the app, make sure its closed)" -ForegroundColor Cyan
            
            Read-Host
            Remove-Item C:\ipscanner.exe -Force

        }
        "15" {
            Write-Host "Entering Imaging Software Section..." -ForegroundColor Blue
            do {
                Clear-Host
                Write-Host "Imaging Software Section" -ForegroundColor DarkCyan
                $imagingchoice = Read-Host @"

1. EzDent-i Fix: DLL error during IO acquisition
2. Schick Drivers
3. Eaglesoft Download
4. Exit Imaging Software Fixes Section

Enter the number of your choice
"@
                switch ($imagingchoice) {
                    "1" {
                        $dllSourcePath = "C:\EzSensor\libiomp5md.dll"
                        $dllDestinationPath = "C:\Program Files (x86)\VATECH\EZDent-i\bin"
                        
                        # Check if the DLL file exists
                        if (Test-Path -Path $dllSourcePath) {
                            Write-Host "Copying the IO Library to fix EzDent" -ForegroundColor Blue
                            try {
                                # Attempt to copy the DLL
                                Copy-Item -Path $dllSourcePath -Destination $dllDestinationPath -Force
                                Write-Host "Operation completed. DLL copied successfully." -ForegroundColor Blue
                            }
                            catch {
                                Write-Host "An error occurred while copying the DLL: $_" -ForegroundColor Red
                            }
                        }
                        else {
                            Write-Host "Error: The DLL 'libiomp5md.dll' was not found at $dllSourcePath." -ForegroundColor Red
                        }

                        Write-Host "Press Enter to continue." -ForegroundColor Blue
                        Read-Host
                    }
                    "2" {
                        Start-Process msedge.exe '--new-window https://www.dentsplysironasupport.com/en-us/user_section/user_section_imaging/schick_brand_software.html'
                        Write-Host "Press Enter to go back" -ForegroundColor Cyan
                        Read-Host

                    }
                    "3" {
                        Start-Process msedge.exe '--new-window https://pattersonsupport.custhelp.com/app/answers/detail/a_id/23400#New%20Server'
                        Write-Host "Press Enter to go back" -ForegroundColor Cyan
                        Read-Host

                    }
                    "4" {
                        Write-Host "Exiting Imaging Software Fixes Section..." -ForegroundColor Blue
                    }
                    Default {
                        Write-Host "Invalid choice. Please select a valid option." -ForegroundColor Red
                        Read-Host "Press Enter to try again"
                    }
                }
            } while ($imagingchoice -ne "4")  # Loop until the user selects to exit
        }

        }

} while ($choice -ne "16")
