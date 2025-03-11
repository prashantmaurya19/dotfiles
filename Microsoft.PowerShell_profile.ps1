Invoke-Expression (&starship init powershell)

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
