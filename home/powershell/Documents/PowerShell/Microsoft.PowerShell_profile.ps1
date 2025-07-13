function Invoke-Starship-TransientFunction {
  &starship module character
}

Invoke-Expression (&starship init powershell)
Enable-TransientPrompt
Import-Module -Name Terminal-Icons

# enviroment variables
$env:JDTLS_JVM_ARGS="-javaagent:$HOME\AppData\Local\nvim-data\mason\packages\jdtls\lombok.jar"
$env:FZF_DEFAULT_OPTS='--height 40% --layout reverse --border'
$env:DESKTOP_WELLPAPER = "C:\Users\prash\Documents\wellpapers\dark-anime-pictures-iwmu3b0sun9r6789.jpg"
$env:JAVA_HOME = "C:\Program Files\Java\jdk-23\"
$env:YAZI_CONFIG_HOME = "C:\Users\prash\.config\yazi\"
$env:EDITOR = "nvim "
$env:YAZI_FILE_ONE  = "C:\Program Files\Git\usr\bin\file.exe"

# Write-Host "$(%HOME%) , $(%EDITOR%)"

$DocPath = "$($HOME)\Documents\"
$DownloadsPath = "$($HOME)\Downloads\"

$FZF_SEARCH_PATHS = @($DocPath,$DownloadsPath) 

function GotoFolder() {
    # Get-ChildItem -Path $FZF_SEARCH_PATHS -Recurse | Where-Object { $_.PSIsContainer } | Invoke-Fzf | Set-Location
  $AllPaths = @($FZF_SEARCH_PATHS) # Start with the search paths themselves

  foreach ($path in $FZF_SEARCH_PATHS) {
    $AllPaths += (Get-ChildItem -Path $path -Directory -Recurse | Select-Object -ExpandProperty FullName)
  }

  $AllPaths | Select-Object -Unique | Invoke-Fzf | Set-Location
}

function RemoveCompelety{
  param(
    [string] $Path
  )
  Remove-Item $Path -Force -Recurse
}

function FnTreeDir(){
  param(
    [string]$Path
  )
  Get-ChildItem -Path $Path -Recurse -File | ForEach-Object {Write-Host $_.FullName.Replace( (Get-Item .).FullName+"\","")}
}

function y {
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp -Encoding UTF8
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
    Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
  }
  Remove-Item -Path $tmp
}

Set-Alias -Name godoc -Value GotoFolder
Set-Alias -Name rmc -Value RemoveCompelety
Set-Alias -Name treedir -Value FnTreeDir
Set-Alias -Name v -Value nvim


Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function AcceptSuggestion

Set-PSReadLineKeyHandler -Chord "Alt+," -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('godoc')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  # GotoFolder $FZF_SEARCH_PATHS
} -BriefDescription "ctrl+, mapping for godoc "
