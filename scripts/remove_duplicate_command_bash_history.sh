cp ~/.bash_history ~/.bash_history_backup
history -a                                              # Append current session history to the history file
history -c                                              # Clear the current shell's history
awk '!seen[$0]++' ~/.bash_history > ~/.bash_history_temp # Filter duplicates
mv ~/.bash_history_temp ~/.bash_history                 # Replace original with cleaned version
history -r                                              # Read the cleaned history file into the current session
