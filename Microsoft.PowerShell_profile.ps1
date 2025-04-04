Invoke-Expression (&starship init powershell)
Import-Module -Name Terminal-Icons

# enviroment variables
$env:JDTLS_JVM_ARGS="-javaagent:$HOME\AppData\Local\nvim-data\mason\packages\jdtls\lombok.jar"
$env:FZF_DEFAULT_OPTS='--height 40% --layout reverse --border'
$env:DESKTOP_WELLPAPER = "C:\Users\prash\Documents\wellpapers\dark-anime-pictures-iwmu3b0sun9r6789.jpg"

$nvim = "$($HOME)\AppData\Local\nvim"
$todo = "$($HOME)\Documents\prashant\TODO.txt"

$LocalPath = @{
  Doc = "$($HOME)\Documents";
}

function GotoFolder([System.String] $path){
  Get-ChildItem $path -Recurse | ? { $_.PSIsContainer } | Invoke-Fzf | Set-Location
}

function GotoDoc{
  GotoFolder $LocalPath["Doc"]
}

Set-Alias -Name godoc -Value GotoDoc


Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function AcceptSuggestion
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
