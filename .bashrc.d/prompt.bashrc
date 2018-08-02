# colors and stuff
DIRTY="\001$(fgcolor 168)\002" # red
READY="\001$(fgcolor 11)\002" # yellow
CLEAN="\001$(fgcolor 30)\002" # green
PATH_COLOR="$(fgcolor 75)" # blueish
PROMPT="»"
STATUS_OK="\001$(fgcolor 35)\002✔"
STATUS_ERROR="\001$(fgcolor 202)\002✘"

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
    if [ $? -gt 0 ]; then
        EXIT="$STATUS_ERROR "
    else
        EXIT="$STATUS_OK "
    fi
    printf "$EXIT"
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


PS1='$(exit_symbol)$(git_prompt)\[$PATH_COLOR\]\W $PROMPT \[$NO_COLOUR\]'



# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
