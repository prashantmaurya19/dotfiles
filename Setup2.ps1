function Check-WingetPackageInstalled {
param (
    [string]$PackageID
  )

  try {
    $wingetOutput = winget list --id=$PackageID --source=winget 2>$null
    if ($wingetOutput -match $PackageID) { #improved match.
      return $true
    } else {
      return $false
    }
  } catch {
    Write-Error "Error checking winget package '$PackageID': $($_.Exception.Message)"
    return $false
  }
}

function Install-WingetPackage {
param (
    [string]$PackageName,
    [string]$PackageID,
    [string]$Scope = "user"
  )

  try {
    Write-Host "Installing '$PackageName' ($PackageID)..."

    $wingetArgs = @(
      "install",
      "--id=$PackageID",
      "--accept-source-agreements",
      "--accept-package-agreements",
      "--source=winget",
      "-e"
    )
    Write-Host "winget $wingetArgs"
    $wingetOutput = & winget $wingetArgs 2>&1

    if ($LASTEXITCODE -ne 0) {
      Write-Error "Failed to install '$PackageName' ($PackageID).Error: $($wingetOutput)"
      return $false
    } else {
      Write-Host "'$PackageName' ($PackageID) installed successfully."
      return $true
    }
  } catch {
    Write-Error "An error occurred installing '$PackageName' ($PackageID): $($_.Exception.Message)"
    return $false
  }
}

function Install-WingetPackageIfNotInstalled {
param (
    [string]$PackageName,
    [string]$PackageID,
    [string]$Scope = "user"
  )
  if (Check-WingetPackageInstalled -PackageID $PackageID) {
    Write-Host "'$PackageName' ($PackageID) is already installed."
  } else {
    Install-WingetPackage -PackageName $PackageName -PackageID $PackageID -Scope $Scope
  }
}

function Install-Packages {
  $mypackages = @(
    @{ Name = "wezterm"; ID = "wez.wezterm" },
    @{ Name = "Git"; ID = "Git.Git" },
    @{ Name = "Neovim"; ID = "Neovim.Neovim" },
    @{ Name = "Starship"; ID = "Starship.Starship" },
    @{ Name = "Postman"; ID = "Postman.Postman" },
    @{ Name = "fzf"; ID = "junegunn.fzf" },
    @{ Name = "zig"; ID = "zig.zig" },
    @{ Name = "JDK 23"; ID = "Oracle.JDK.23" },
    @{ Name = "Python 3.13"; ID = "Python.Python.3.13" },
    @{ Name = "VSCode"; ID = "Microsoft.VisualStudioCode" },
    @{ Name = "TranslucentTB"; ID = "CharlesMilette.TranslucentTB" },
    @{ Name = "Windows Terminal"; ID = "Microsoft.WindowsTerminal" },
    @{ Name = "WinRAR"; ID = "RARLab.WinRAR" }
  )

  foreach ($package in $mypackages) {
    Install-WingetPackageIfNotInstalled -PackageName $($package.Name) -PackageID $($package.ID)
  }
}

Install-Packages

& .\stow.ps1 -All -Restore
