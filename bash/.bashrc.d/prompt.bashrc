# colors and stuff
DIRTY="\001$(fgcolor 168)\002" # red
READY="\001$(fgcolor 11)\002" # yellow
CLEAN="\001$(fgcolor 30)\002" # green
PATH_COLOR="$(fgcolor 75)" # blueish
STATUS_OK=""
STATUS_ERROR="\001$(fgcolor 202)\002\uf6f7"

# kubectl context
k8s_prompt() {
    if hash kubectl 2>/dev/null; then
        local glyph=$'\ufd31'
        local context=$(kubectl config current-context)
        local contextstatus=$CLEAN
        if [[ $context == *"prod"* ]]; then
            contextstatus=$READY
        fi
        printf "─⸨${contextstatus}${glyph} ${context}$PATH_COLOR⸩"
    else
        # no kubectl installed
        printf ""
    fi    
}
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
           gitremote="↑"
        fi

        if [[ $git == *"<"* ]]; then
            gitremote="↓"
        fi

        if [[ $git == *"<>"* ]]; then
            gitremote="⇅"
        fi
        local gitstash=""
        if [[ $git == *"$"* ]]; then
            gitstash="⚑"
        fi

        IFS=' |=|<|>' read -ra array <<< "$git"
        gitbranch="${array[0]##*/}"
        local gitglyph=$'\uf7a1'         
        #printf "${gitstatus}[${gitglyph} ${gitbranch:0:20}… $gitremote$gitstash]"
        printf "─⸨${gitstatus}${gitglyph} $gitremote$gitstash ${gitbranch}$PATH_COLOR⸩"

    fi
}

path_icon() {
    local glyph=$'\ue5ff' # regular folder
    if [[ "${PWD}" == "${HOME}" ]]; then
        glyph=$'\uf015'
    elif [[ "$PWD}" == "${HOME}/projects/"* ]]; then
        glyph=$'\ue5fb'
    elif [[ "$PWD}" == "${HOME}/github/"* ]]; then
        glyph=$'\ue5fd'
    elif [[ "${PWD##/home/}" == "${PWD}" ]]; then
        glyph=$'\ue5fc'
    
    fi
    printf "${glyph}"
}

exit_symbol() {
    local code="$?"
    if [ $code -gt 0 ]; then
        EXIT="⸨$STATUS_ERROR $code$PATH_COLOR⸩"
    else
        EXIT="⸨$(path_icon)⸩"
    fi
    printf "$EXIT"
}

prompt() {
    local prompt="➤"
    printf "$prompt"

}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


PS1='\[$PATH_COLOR\]┌─$(exit_symbol)$(k8s_prompt)\[$PATH_COLOR\]$(git_prompt)\n\[$PATH_COLOR\]└─⸨\w⸩─$(prompt) \[$NO_COLOUR\]'



# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
