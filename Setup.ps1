function Check-WingetPackageInstalled {
param (
    [string]$PackageName
  )

  try {
    $wingetOutput = winget list --id=$PackageName --source=winget 2>$null
    if ($wingetOutput -match $PackageName) {
      return $true 
    } else {
      return $false 
    }
  }
  catch {
    Write-Error "Error checking winget package: $($_.Exception.Message)"
    return $false
  }
}

function Install-WingetPackage {
param (
    [string]$PackageName,
    [string]$PackageID, # Optional: Use PackageID for more precise targeting
    [string]$Scope = "user" #Optional: Default scope to user
  )
  try {
    Write-Host "Installing $PackageName..."

    # Construct the winget command
    $wingetCommand = "winget install "

    if ($PackageID) {
      $wingetCommand += "--id=$PackageID "
    } else {
      $wingetCommand += "$PackageName "
    }

    $wingetCommand += "--accept-source-agreements --accept-package-agreements --scope $Scope -e"
    $wingetOutput = Invoke-Expression $wingetCommand 2>&1 # Capture both stdout and stderr
    if ($LASTEXITCODE -ne 0) {
      Write-Error "Failed to install $PackageName. Error: $($wingetOutput)"
      return $false
    } else {
      Write-Host "$PackageName installed successfully."
      return $true
    }
  }
  catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    return $false
  }
}

function Install-WingetPakageIfNotInstalled{
param(
    [string]$PackageID, # Optional: Use PackageID for more precise targeting
    [string]$Scope = "user" #Optional: Default scope to user
  )
  if (Check-WingetPackageInstalled -PackageName $PackageID) {
    Write-Host "$PackageID is installed."
  } else {
    Install-WingetPackage -PackageName $PackageID -PackageID $PackageID -Scope $Scope
  }
}


function Install-Packages(){
  $mypackages = @(
    "Git.Git",
    "wez.wezterm",
    "Neovim.Neovim",
    "Starship.Starship",
    "Postman.Postman",
    "junegunn.fzf",
    "zig.zig",
    "Oracle.JDK.23",
    "Python.Python.3.13",
    "Microsoft.VisualStudioCode",
    "CharlesMilette.TranslucentTB",
    "Microsoft.WindowsTerminal",
    "RARLab.WinRAR"
  )
  foreach ($item in $mypackages) {
    Install-WingetPakageIfNotInstalled -PackageID $item
  }
}

Install-Packages

& .\stow.ps1 -All -Restore
