# colors and stuff
DIRTY="\001$RED\002"
READY="\001$YELLOW\002"
CLEAN="\001$CYAN\002"
PATH_COLOR=$BLUE$BOLD
PROMPT_COLOR=$NO_COLOUR$CYAN
PROMPT="»"
STATUS_OK="✔"
STATUS_ERROR="✘"

# git prompt
git_prompt() {
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    # Explicitly unset color (default anyhow). Use 1 to set it.
    GIT_PS1_SHOWCOLORHINTS=0
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_SHOWUPSTREAM="auto"

    local git=$(__git_ps1 "%s")

    if [ "$git" ]; then
        local gitstatus=$CLEAN
        if [[ $git == *"+"* ]]; then
            gitstatus=$READY
        fi

        if [[ $git == *"%"* ]] || [[ $git == *"*"* ]]; then
            gitstatus=$DIRTY
        fi

        local gitremote=""
        if [[ $git == *">"* ]]; then
           gitremote="↑ "
        fi

        if [[ $git == *"<"* ]]; then
            gitremote="↓ "
        fi

        if [[ $git == *"<>"* ]]; then
            gitremote="⇅ "
        fi
        local gitstash=""
        if [[ $git == *"$"* ]]; then
            gitstash="⚑ "
        fi

        IFS=' |=|<|>' read -ra array <<< "$git"
        local gitbranch=${array[0]}

         printf "${gitstatus}$gitbranch $gitremote$gitstash"

    fi
}

exit_symbol() {
    if [ $? != 0 ]; then
        EXIT="$DIRTY$STATUS_ERROR "
        #✗
    else
        EXIT="$CLEAN$STATUS_OK "
        #✓
    fi
    printf "$EXIT"
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


PS1='$(exit_symbol)$(git_prompt)\[$PATH_COLOR\]\W \[$PROMPT_COLOR\]$PROMPT \[$NO_COLOUR\]'


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
