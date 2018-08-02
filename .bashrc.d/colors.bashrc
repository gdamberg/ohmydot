# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias egrep='egrep --color=auto'
fi

#  syntax highlighting in less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# set color of text
# used in strings with ech, eg: `echo -e "$(fgcolor 121)$(bgcolor 19)Hello world!"`
# reset color after usage or it will mess up the prompt...
function fgcolor() {
  if [ ! -z "$1" ]
  then
    echo "$(tput setaf $1)"
  fi
}
# set color of background
function bgcolor() {
  if [ ! -z "$1" ]
  then
    echo "$(tput setab $1)"
  fi
}


# COLORS
export RED="$(fgcolor 168)"
export YELLOW="$(fgcolor 120)"
export BLUE="$(fgcolor 4)"
export CYAN="$(fgcolor 75)"

export NO_COLOUR="$(tput sgr0)"
export REVERSE="$(tput rev)"
export BOLD="$(tput bold)"
export UNDERLINE="$(tput smul)"

function _colorgrid( ) {
    iter=0
    while [ $iter -lt 256 ]
    do
        # only print four columns in first row for astetic reasons"
        if [[ $iter -gt 0 ]]
        then
            echo -en "$(tput setaf $iter)███ $iter     "
            iter=$[$iter+1]
            echo -en "$(tput setaf $iter)███ $iter     "
            iter=$[$iter+1]
        fi
        echo -en "$(tput setaf $iter)███ $iter     "
        iter=$[$iter+1]
        echo -en "$(tput setaf $iter)███ $iter     "
        iter=$[$iter+1]
        echo -en "$(tput setaf $iter)███ $iter     "
        iter=$[$iter+1]
        echo -en "$(tput setaf $iter)███ $iter     "

        iter=$[$iter+1]
        echo -e $NO_COLOUR
    done
}

function colors() {
  _colorgrid | column -t
}
