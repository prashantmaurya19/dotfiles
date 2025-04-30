param(
  [string] $Ns="",
  [switch] $All,
  [switch] $Backup,
  [switch] $Restore,
  [switch] $Debug
) 
if(( $Backup -and $Restore ) -or (-Not $Backup -and -Not $Restore)){
  Write-Host "Pls select one operation at a time!!" -ForegroundColor Red
  return;
}

if(($Ns -eq "") -and -NOT $All){
  Write-Host "Pls provide -Ns or pass -All option!!" -ForegroundColor Red
  return;
}
$CWD = (Get-Item .).FullName
$config_dir = "$CWD\home"
# destination is the real location of folder or file
# source is the dotfile folder location of folder or file

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
  # param(
  #   [string] $namespace
  # )
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
  # if(Test-Path -Path $dest){
  #   Remove-Item -Path $dest -Force -Recurse
  # }
  Copy-Item $source -Destination $dest -Recurse -Force
}

DoRestore -Namespace $Ns
