# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
# extra code completions
if hash kubectl 2>/dev/null; then
    source <(kubectl completion bash)
fi

if hash helm 2>/dev/null; then
    source <(helm completion bash)
fi

if hash minikube 2>/dev/null; then
    source <(minikube completion bash)
fi

# code completion aws client
if [ -e $HOME/.local/bin/aws_completer ]; then
    complete -C '$HOME/.local/bin/aws_completer' aws
fi

# use dircolors if it exists
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# add  $HOME/bin to path if it exists
if [ -d $HOME/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi

# init sdkman if installed
if [ -d $HOME/.sdkman ]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

# jenv
if [ -d $HOME/.jenv ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi
# pyenv
if [ -d $HOME/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
export PATH="$PATH:$HOME/.local/bin"

# krew kubectl plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# load .bashrc_* 
if [ -f "$HOME/.bashrc_functions" ]; then
  source "$HOME/.bashrc_functions"
fi
if [ -f "$HOME/.bashrc_alias" ]; then
  source "$HOME/.bashrc_alias"
fi
if [ -f "$HOME/.bashrc_settings" ]; then
  source "$HOME/.bashrc_settings"
fi
if [ -f "$HOME/.bashrc_local" ]; then
  source "$HOME/.bashrc_local"
fi
if [ -f "$HOME/.bashrc_prompt" ]; then
  source "$HOME/.bashrc_prompt"
fi