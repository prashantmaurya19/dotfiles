FZF_RESULT="$(history | fzf | cut -c 6-)"

if [ FZF_RESULT == "" ]; then
  echo "No Command Selection"
else
  $FZF_RESULT
fi
