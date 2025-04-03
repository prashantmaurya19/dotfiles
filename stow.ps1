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

$CWD = (Get-Item .).FullName

$namespace = @{
  "wezterm"=@(".wezterm.lua");
  "powershell" =@("Microsoft.PowerShell_profile.ps1");
  "starship"=@("starship.toml");
  "glazewm"=@(
    ".glzr\glazewm\config.yaml",
    ".glzr\zebar\starter\with-glazewm.html" ,
    ".glzr\zebar\starter\with-glazewm.zebar.json" 
  );
}

$location_pair = @{
  ".wezterm.lua" = "$HOME\";
  "Microsoft.PowerShell_profile.ps1"="$HOME\Documents\PowerShell\";
  "starship.toml" = "$HOME\.config\";
  ".glzr\glazewm\config.yaml" = "$HOME\";
  ".glzr\zebar\starter\with-glazewm.html" = "$HOME\";
  ".glzr\zebar\starter\with-glazewm.zebar.json" = "$HOME\";
}
# $ignore = @("stow.ps1","README.md","WindowsTerminalSettings.json")

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
  # Write-Host "Debug[S:$source & D:$dest]" -ForegroundColor Cyan
  MakeDirs -Fname $source
  # $out = New-Item -ItemType Directory -Path $source -Force
  if(-Not $Debug){
    Copy-Item $dest -Destination $source -Recurse -Force
  }
}

function DoRestore(){
param(
    [string] $Fname
  )

  $source = Get-SourcePath -Fname $Fname
  $dest = Get-DestinationPath -Fname $Fname
  MakeDirs -Fname $dest
  # Write-Host "Debug[S:$source & D:$dest]" -ForegroundColor Cyan
  if(Test-Path -Path $dest){
    Remove-Item -Path $dest -Force -Recurse
  }
  if(-Not $Debug){
    Copy-Item $source -Destination $dest -Recurse -Force
  }
}

function CheckIsExistDestination(){
  param(
    [string] $Fname
  )
  return Test-Path -Path (Get-DestinationPath -Fname $Fname)
}

function CheckIsExistSource(){
  param(
    [string] $Fname
  )
  return Test-Path -Path (Get-SourcePath -Fname $Fname)
}

if(-Not($Ns -eq "")){
  if($namespace.ContainsKey($Ns)){
    foreach($h in $namespace[$Ns]){
      if($Backup){
	if(-Not (CheckIsExistDestination -Fname $h)) {
	  Write-Host "$h is not found destination!!!!" -ForegroundColor Red
	}else{
	  DoBackup -Fname $h
	  Write-Host "Backup Done for $h!!" -ForegroundColor Green
	}
      }elseif($Restore){
	if(-Not (CheckIsExistSource -Fname $h)) {
	  Write-Host "$location_pair[$h] is not found at source!!!!" -ForegroundColor Red
	}else{
	  DoRestore -Fname $h
	  Write-Host "Restore Done for $h!!" -ForegroundColor Green
	}
      }
    }
  }else{
    Write-Error "$Ns is not found!!"
  }
}elseif($All) {
  foreach($h in $location_pair.GetEnumerator()){
    if($Backup -and (CheckIsExistDestination -Fname $h.Name)){
      DoBackup -Fname $h.Name
      Write-Host "Backup Done for $($h.Name)!!" -ForegroundColor Green
    }elseif($Restore -and (CheckIsExistSource -Fname $h.Name)){
      DoRestore -Fname $h.Name
      Write-Host "Backup Done for $($h.Name)!!" -ForegroundColor Green
    }
  }
}

