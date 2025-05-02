param(
  [string] $Ns="",
  [switch] $All
) 

if(($Ns -eq "") -and -NOT $All){
  Write-Host "Pls provide -Ns or pass -All option!!" -ForegroundColor Red
  return;
}
$CWD = (Get-Item .).FullName
$config_dir = "$CWD\home"

function MakeDirs(){
  param(
    [string] $Fname
  )
  $directoryPath = Split-Path $Fname
  # Write-Host "Debug : Folder is $directoryPath" -ForegroundColor Cyan
  $out = New-Item -ItemType Directory -Path $directoryPath -Force
}

function Get-SourcePath(){
  param(
    [string] $Namespace #folder or file name
  )
  return "$config_dir\$namespace\"
}

function Get-DestinationPath(){
  return "$HOME\"
  # return "$CWD\test"
}

function DoBackup(){
param(
    [string] $namespace
  )
  # implement later
}

function DoRestore(){
param(
    [string] $Namespace
  )

  $source = "$(Get-SourcePath -Namespace $Namespace)\*"
  $dest = Get-DestinationPath
  # MakeDirs -Fname $dest
  # Write-Host "Debug[S:$source & D:$dest]" -ForegroundColor Cyan
  if(-Not(Test-Path -Path (Get-SourcePath -Namespace $Namespace))){
    Write-Host "$Namespace config Not Found!!!" -ForegroundColor Red
    return
  }
  Copy-Item $source -Destination $dest -Recurse -Force
  Write-Host "$Namespace config Transferred successfully!!!" -ForegroundColor Green
}

DoRestore -Namespace $Ns
# all option remain to implement
