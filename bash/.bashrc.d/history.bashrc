function log-history () {
    if [[ $- = *i* ]] && (( EUID != 0 )); then
        [[ -d ~/.logs ]] || mkdir ~/.logs
        `echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log`
    fi
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth
HISTCONTROL=ignoredups:erasedups  # no duplicate entries

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=20000

# on each command write to istory and relaod history file
export PROMPT_COMMAND="history -a; history -n; log-history"

# append to the history file, don't overwrite it
shopt -s histappend
