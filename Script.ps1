  $AppsWithOSReqs = Get-CMApplication | Where-Object { $_.SDMPackageXML -match "Operating system One of" -and $_.IsEnabled -eq $True -and $_.IsDeployed -eq $True } 
  ForEach ($App in $AppsWithOSReqs) {
        $Application = Get-CMApplication -ID $App.CI_ID | ConvertTo-CMApplication
        If ($Application.DeploymentTypes.Requirements.Count -eq 1) {
            If ( $Application.DeploymentTypes.Requirements.Name -match "All Windows 10") {
                If ( $Application.DeploymentTypes.Requirements.Name -match "All Windows 11") {
                    Write-Host "ID: $($App.CI_ID) | DisplayName: $($Application.Title) | Requirements: $($Application.DeploymentTypes.Requirements.Name)" -ForegroundColor Green
                } Else {
                    Write-Host "ID: $($App.CI_ID) | DisplayName: $($Application.Title) | Requirements: $($Application.DeploymentTypes.Requirements.Name)" -ForegroundColor Red
                }
            }
        } Else {
            $count = $Application.DeploymentTypes.Requirements.Count
            For ($num = 0 ; $num -lt $count ; $num++){
                If ($Application.DeploymentTypes.Requirements[$num].Name -match "Operating system One of" -and $Application.DeploymentTypes.Requirements[$num].Name -match "All Windows 10") {
                    If ( $Application.DeploymentTypes.Requirements.Name -match "All Windows 11") {
                        Write-Host "ID: $($App.CI_ID) | DisplayName: $($Application.Title) | Requirements: $($Application.DeploymentTypes.Requirements[$num].Name)" -ForegroundColor Green
                    } Else {
                        Write-Host "ID: $($App.CI_ID) | DisplayName: $($Application.Title) | Requirements: $($Application.DeploymentTypes.Requirements[$num].Name)" -ForegroundColor Red
                    }
                }
            }
        }
  }