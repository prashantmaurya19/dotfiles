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

$nvim = "$($HOME)\AppData\Local\nvim"

$LocalPath = @{
  Doc = "$($HOME)\Documents";
}

$FZF_SEARCH_PATHS = @( "$($HOME)\Documents")

function GotoFolder([string] $path){
  Get-ChildItem $path -Recurse | Where-Object { $_.PSIsContainer } | Invoke-Fzf | Set-Location
}

function GotoDoc{
  GotoFolder $FZF_SEARCH_PATHS
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

Set-Alias -Name godoc -Value GotoDoc
Set-Alias -Name rmc -Value RemoveCompelety
Set-Alias -Name treedir -Value FnTreeDir


Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function AcceptSuggestion

Set-PSReadLineKeyHandler -Chord "Ctrl+," -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('godoc')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
} -BriefDescription "ctrl+, mapping for godoc "

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
