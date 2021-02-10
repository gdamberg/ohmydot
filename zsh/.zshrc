# enable completions
autoload -Uz compaudit compinit
autoload -U bashcompinit && bashcompinit # support bash completions

# History
export HISTSIZE=100000      # Nearly infinite history; essential to building a cli 'library' to use with fzf/etc
export SAVEHIST=100000
setopt share_history        # share it across sessions
setopt extended_history     # add timestamps to history
setopt hist_ignore_all_dups # don't record dupes in history
setopt hist_ignore_space    # remove command line from history list when first character on the line is a space
setopt hist_reduce_blanks   # remove superflous blanks
setopt append_history       # append to history
setopt inc_append_history   # append commands directly, not at end of session
bindkey '^[[A' history-beginning-search-backward #up-line-or-search     # up arrow bindkey search in history with up/down keys
bindkey '^[[B' history-beginning-search-forward #down-line-or-search   # down arrow


# completions
zstyle ':completion:*' completer _complete _match _prefix:-complete _list _correct _approximate _prefix:-approximate _ignored
zstyle ':completion:*:prefix-complete:*' completer _complete
zstyle ':completion:*:prefix-approximate:*' completer _approximate
# configure the match completer, more flexible of GLOB_COMPLETE
# with original set to only it doesn't act like a `*' was inserted at the cursor position
zstyle ':completion:*:match:*' original only
# first case insensitive completion, then case-sensitive partial-word completion, then case-insensitive partial-word completion
# (with -_. as possible anchors)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=* r:|=*' 'm:{a-z}={A-Z} r:|[-_.]=* r:|=*'
# allow 2 erros in correct completer
zstyle ':completion:*:correct:*' max-errors 2 not-numeric
## allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) numeric )'
# meu selection with 2 candidates or more
zstyle ':completion:*' menu select=2
#zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# Add colors in completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload colors && colors

# Messages/warnings format
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[01;31m%}---- %d%{\e[m%}'
zstyle ':completion:*:messages' format $'%{\e[01;04;31m%}---- %d%{\e[m%}'
zstyle ':completion:*:warnings' format $'%{\e[01;04;31m%}---- No matches for: %d%{\e[m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[m%}'
# make completions appear below the description of which listing they come from
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' select-prompt %SScrolling active: current selection at %p%s

## Some functions, like _apt and _dpkg, are very slow. You can use a cache in order to proxy the list of results:
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# complete man pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

## If you end up using a directory as argument, this will remove the trailing slash (usefull in ln):
#zstyle ':completion:*' squeeze-slashes true

## cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd

zstyle ':completion:*:(ls|mv|cd|chdir|pushd|popd):*' special-dirs ..

## ignores filenames already in the line
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

## Ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'

## don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# A newly added command will may not be found or will cause false
# correction attempts, if you got auto-correction set. By setting the
# following style, we force accept-line() to rehash, if it cannot
# find the first word on the command line in the $command[] hash.
zstyle ':acceptline:*' rehash true



# setopts
setopt autocd               # type bare dir name and cd to it e.g. `$ /`
setopt complete_in_word     # don't move cursor to end of line on completion
setopt no_always_to_end
setopt list_packed
setopt interactive_comments # allow comments even in interactive shells.
unsetopt beep               # don't bloody beep
unsetopt bg_nice            # don't re-nice bg procs to lower priority
setopt correct              # autocorrect spelling for args
setopt correct_all          # autocorrect spelling for args
unsetopt flow_control       # disable ^S/^Q flow control
unsetopt hup                # don't send the HUP signal to running jobs when the shell exits.
unsetopt list_beep          # don't beep on ambiguous completions
unsetopt local_options      # allow funcs to have their own setopts (i.e. don't change globally)
unsetopt local_traps        # allow funcs to have their own signal trap opts (i.e. don't change globally)
typeset -U PATH             # remove duplicate paths
setopt autocd extendedglob nomatch notify
bindkey -e

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#powerlevel10k
[[ ! -f /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme ]] || source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Environment variables
export PAGER='less'
# --RAW-CONTROL-CHARS:   translate raw escape sequences to colors
# --squeeze-blank-lines: no more than one blank line in a row
# --quit-on-intr:        quit on interrupt, e.g. C-c
# --quit-if-one-screen:  quit if content fills less than the screen
# --no-init:             don't clear screen on exit
# --mouse:               support mouse - only less version >=551 (`brew install less` on mac)
export LESS='--RAW-CONTROL-CHARS --squeeze-blank-lines --quit-on-intr --quit-if-one-screen --no-init' # --mouse
export TERM=xterm-256color # True Color support in terminals and TUI programs that support it (e.g. vim)
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_COLLATE=C

# python pyenv etc
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    # Pyenv (will add shims to front of $PATH)
    eval "$(pyenv init -)"

    # Ensure commands from virtualenvwrapper are available, no matter which
    # Python version is active. This is equiv to sourcing virtualenvwrapper.sh
    pyenv virtualenvwrapper
    # Always require a virtualenv to use pip
    export PIP_REQUIRE_VIRTUALENV=true
fi

# add a function path
fpath=($HOME/.zsh/functions $HOME/.zsh/completions $fpath)
# autoload custom functions
autoload -U ${HOME}/.zsh/functions/*

# source my alias files
source ${HOME}/.zsh/alias

# SDKMAN
export SDKMAN_DIR="/Users/gordam/.sdkman"
[[ -s "/Users/gordam/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/gordam/.sdkman/bin/sdkman-init.sh"

# load local .zshrc overrides and additions if present
[[ ! -f ~/.zshrc_local ]] || source ~/.zshrc_local

compinit -du