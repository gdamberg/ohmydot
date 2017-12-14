# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# COLORS
export BLACK="$(tput setaf 0)"
export RED="$(tput setaf 1)"
export GREEN="$(tput setaf 2)"
export YELLOW="$(tput setaf 3)"
export BLUE="$(tput setaf 4)"
export PURPLE="$(tput setaf 5)"
export CYAN="$(tput setaf 6)"
export WHITE="$(tput setaf 7)$(tput bold)"
export GRAY="$(tput setaf 7)"

export BG_BLACK="$(tput setab 0)"
export BG_RED="$(tput setab 1)"
export BG_GREEN="$(tput setab 2)"
export BG_YELLOW="$(tput setab 3)"
export BG_BLUE="$(tput setab 4)"
export BG_PURPLE="$(tput setab 5)"
export BG_CYAN="$(tput setab 6)"
export BG_WHITE="$(tput setab 7)$(tput bold)"
export BG_GRAY="$(tput setab 7)"

export NO_COLOUR="$(tput sgr0)"
export REVERSE="$(tput rev)"
export BOLD="$(tput bold)"
export UNDERLINE="$(tput smul)"

function colors() {
  echo -e $BLACK           "black             " $REVERSE "reverse" $NO_COLOUR
  echo -e $RED             "red               " $REVERSE "reverse" $NO_COLOUR
  echo -e $GREEN           "green             " $REVERSE "reverse" $NO_COLOUR
  echo -e $YELLOW          "yellow            " $REVERSE "reverse" $NO_COLOUR
  echo -e $BLUE            "blue              " $REVERSE "reverse" $NO_COLOUR
  echo -e $PURPLE          "purple            " $REVERSE "reverse" $NO_COLOUR
  echo -e $CYAN            "cyan              " $REVERSE "reverse" $NO_COLOUR
  echo -e $WHITE           "white             " $REVERSE "reverse" $NO_COLOUR
  echo -e $GRAY            "gray              " $REVERSE "reverse" $NO_COLOUR

  echo -e $BOLD$BLACK      "bold black        " $REVERSE "reverse" $NO_COLOUR
  echo -e $BOLD$RED        "bold red          " $REVERSE "reverse" $NO_COLOUR
  echo -e $BOLD$GREEN      "bold green        " $REVERSE "reverse" $NO_COLOUR
  echo -e $BOLD$YELLOW     "bold yellow       " $REVERSE "reverse" $NO_COLOUR
  echo -e $BOLD$BLUE       "bold blue         " $REVERSE "reverse" $NO_COLOUR
  echo -e $BOLD$PURPLE     "bold purple       " $REVERSE "reverse" $NO_COLOUR
  echo -e $BOLD$CYAN       "bold cyan         " $REVERSE "reverse" $NO_COLOUR
  echo -e $BOLD$WHITE      "bold white        " $REVERSE "reverse" $NO_COLOUR

  echo -e $BG_BLACK  "black            "$NO_COLOUR
  echo -e $BG_RED    "red              "$NO_COLOUR
  echo -e $BG_GREEN  "green            "$NO_COLOUR
  echo -e $BG_YELLOW "yellow           "$NO_COLOUR
  echo -e $BG_BLUE   "blue             "$NO_COLOUR
  echo -e $BG_PURPLE "purple           "$NO_COLOUR
  echo -e $BG_CYAN   "cyan             "$NO_COLOUR
  echo -e $BG_WHITE  "white            "$NO_COLOUR
  echo -e $BG_GRAY   "gray             "$NO_COLOUR

  echo -e " default           " $REVERSE "reverse" $NO_COLOUR
}


