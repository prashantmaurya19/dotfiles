param(
  [string] $fname="",
  [System.Boolean] $All=$true,
  [System.Boolean] $Backup=$false,
  [System.Boolean] $Restore=$false
) 


if(( $Backup -and $Restore ) -or (-Not $Backup -and -Not $Restore)){
  Write-Host "Pls select one operation at a time!!" -ForegroundColor Red
  return;
}

$CWD = (Get-Item .).FullName

$location_pair = @{
    ".wezterm.lua" = "$HOME\";
  "starship.toml" = "$HOME\.config\"
}
$ignore = @("stow.ps1","README.md","WindowsTerminalSettings.json")

# destination is the real location of folder or file
# source is the dotfile folder location of folder or file

function Get-SourcePath(){
  param(
    [string] $Fname #folder or file name
  )
  return "$CWD\$Fname"
}

function Get-DestinationPath(){
  param(
    [string] $Fname #folder or file name
  )
  return "$($location_pair[$Fname])$Fname"
}

function DoBackup(){
param(
    [string] $Fname
  )

  $source = Get-SourcePath -Fname $Fname
  $dest = Get-DestinationPath -Fname $Fname

  # Write-Host "$source <-> $dest"
  Copy-Item $dest -Destination $source -Recurse -Force
}

function DoRestore(){
param(
    [string] $Fname
  )

  $source = Get-SourcePath -Fname $Fname
  $dest = Get-DestinationPath -Fname $Fname
  Copy-Item $source -Destination $dest -Recurse -Force
}

if(-Not($fname -eq "")){
  if(-Not (Test-Path -Path (Get-SourcePath -Fname $fname))) {
    Write-Host "$fname is not found!!!!" -ForegroundColor Red
  }else{
    if($Backup){
      DoBackup -Fname $fname
    }elseif($Restore){
      DoRestore -Fname $fname
    }
  }
}elseif($All) {
  foreach($ff in (Get-ChildItem -Path $CWD)){
    $f = ($ff.FullName.Replace($CWD+"\",""))
    if(($f -in $ignore) -or -Not $location_pair.ContainsKey($f)){
      Write-Host $f -ForegroundColor Red
      continue;
    }
    # Write-Host $f -ForegroundColor Green
    if($Backup){
      DoBackup -Fname ($ff.FullName.Replace($CWD+"\",""))
    }elseif($Restore){
      DoRestore -Fname ($ff.FullName.Replace($CWD+"\",""))
    }
  }
}

