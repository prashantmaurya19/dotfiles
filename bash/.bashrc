# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519

eval "$(starship init bash)"

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

_fzf_history_search_and_insert() {
  # Use fzf to search history.
  # --print-query keeps the current prompt content if no history item is selected.
  # --expect=ctrl-v is an example to show how to handle special keys
  # In this example, 'ctrl-v' can be used to paste the command without running it (optional)
  local result
  result=$(
    history | fzf --tac --query="$READLINE_LINE" | cut -c 8-
  )

  # Check if fzf was canceled (result is empty)
  if [[ -z "$result" ]]; then
    return 1
  fi

  # Split the result into the key pressed and the selected command
  local key_pressed command_selected
  key_pressed=$(echo "$result" | head -n 1)
  command_selected=$(echo "$result" | tail -n 1)

  # Check if fzf was canceled after displaying the list (e.g., via ESC or Ctrl-C)
  if [[ "$key_pressed" == "" ]]; then
    # If canceled, restore the original line
    READLINE_LINE="$READLINE_LINE"
    READLINE_POINT=$READLINE_POINT
    return 0
  fi

  # 1. Update the prompt line with the selected command
  READLINE_LINE="$command_selected"
  # 2. Move the cursor to the end of the line
  READLINE_POINT=${#READLINE_LINE}

  # Optional: If you want to execute the command immediately on 'Enter',
  # you'll need a different approach or to execute the function directly.
  # The default 'Enter' behavior in fzf will land here, and you can type 'Enter' again.

  # Optional: Handle the special key press (e.g., run immediately on Enter)
  # if [[ "$key_pressed" == "enter" ]]; then
  # You can't directly execute here, but you can set a flag or try to
  # simulate an 'Enter' key press, which is complex and often discouraged.
  # Setting the line and point is usually enough.
  # : # Do nothing extra, just set the line
  # elif [[ "$key_pressed" == "ctrl-v" ]]; then
  # If Ctrl-V was pressed, it just pastes the command like 'Enter' but
  # you know the user explicitly chose to paste without running.
  # : # Do nothing extra, just set the line
  # fi
}

IGNORED_DIRS=(
  "mason"
  "fnm"
  ".git"
  ".vscode"
  "target"
  "node_modules"
  "Trash"
  "share"
  "venv"
  ".java"
)

IGNORED_PATH_DIRS=(
  "$HOME/AppData"
  "$HOME/snap"
  "$HOME/.cache"
  "$HOME/.yarn"
  "$HOME/.m2"
  "$HOME/.fonts"
  "$HOME/.npm"
  "$HOME/.docker"
  "$HOME/.var"
  "$HOME/.dotnet"
  "$HOME/.fonts"
  "$HOME/.gnupg"
  "$HOME/.m2"
  "$HOME/.bun"
  "$HOME/.mongodb"
  "$HOME/.npm"
  "$HOME/.pki"
  "$HOME/.ssh"
  "$HOME/.sts4"
  "$HOME/Apps"
  "$HOME/.config"
)

# 2. Build the string by joining the array elements with ' -o -name '
# We use parameter expansion to join the elements.
# The result will be: "Trash -o -name .vscode -o -name share..."
JOINED_DIRS="${IGNORED_PATH_DIRS[@]/#/ -o -path } -prune ${IGNORED_DIRS[@]/#/ -o -name }"

# 3. Prepend the first '-name ' to the entire string
# We remove the first ' -o -name ' which is redundant at the beginning.
FZF_IGNORE_DIR="${JOINED_DIRS:4}"

_fzf_open_file() {
  local result
  result=$(
    find ~ \( $FZF_IGNORE_DIR \) -prune -o -type f -print | fzf
  )

  if [[ -z "$result" ]]; then
    return 1
  fi

  # Split the result into the key pressed and the selected command
  local key_pressed command_selected
  key_pressed=$(echo "$result" | head -n 1)
  command_selected=$(echo "$result" | tail -n 1)

  if [[ "$key_pressed" == "" ]]; then
    # If canceled, restore the original line
    return 0
  fi

  nvim $command_selected

}

_fzf_open_folder() {
  local result
  result=$(
    find ~ \( $FZF_IGNORE_DIR \) -prune -o -type d -print | fzf
  )

  if [[ -z "$result" ]]; then
    return 1
  fi

  # Split the result into the key pressed and the selected command
  local key_pressed command_selected
  key_pressed=$(echo "$result" | head -n 1)
  command_selected=$(echo "$result" | tail -n 1)

  if [[ "$key_pressed" == "" ]]; then
    # If canceled, restore the original line
    return 0
  fi

  cd $command_selected

  if [ "$(which wezterm)" != "" ]; then
    wezterm cli rename-workspace "${PWD##*/}"
  fi

}

alias git-push-main='git push origin main'
alias cls='clear'
alias startup='python3 ~/Documents/coding/startup/main.py'
alias rwsf='wezterm cli rename-workspace "${PWD##*/}"'
alias git-commit='git add . && git commit -m'
alias git-dev='git add . && git commit -m "dev : some changes"'
alias git-add='git add . && git commit -m "add : some addition"'
alias git-fix='git add . && git commit -m "add : some fixes"'
alias git-dev-push='git add . && git commit -m "dev : some changes" && git push origin main'
alias git-add-push='git add . && git commit -m "add : some addition" && git push origin main'
alias git-fix-push='git add . && git commit -m "add : some fixes" && git push origin main'
alias fcdv='. ~/Documents/linux-dotfiles/scripts/cd_and_open_dir_in_nvim.sh'
alias dir='lsd -a -1'
alias v='nvim'
alias vleet='nvim leetcode.nvim'
alias vs='nvim -S s.vim'
alias y='yazi'

bind -x '"\e,":"_fzf_open_folder"'
bind -x '"\e.":"_fzf_open_file"'
bind -x '"\em":"_fzf_history_search_and_insert"'

export EDITOR="nvim"
export ADW_DEBUG_COLOR_SCHEME=prefer-dark
export PATH=$PATH:/usr/bin/zig/
export PATH=$PATH:~/nvim/bin/
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share
export XDG_DATA_DIRS=$XDG_DATA_DIRS:~/.local/share/flatpak/exports/share
export XAUTHORITY=$HOME/.Xauthority
export DOTFILES=$HOME/Documents/dotfiles
# export HISTCONTROL=ignoreboth:erasedups
# export HISTSIZE=5000
# export HISTFILESIZE=10000

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/prashant/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/prashant/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/prashant/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/prashant/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# conda activate

# fnm
FNM_PATH="/home/prashant/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# source -- ~/.local/share/blesh/ble.sh

# opencode
export PATH=/home/prashant/.opencode/bin:$PATH
