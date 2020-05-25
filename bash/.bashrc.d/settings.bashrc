#settings

export EDITOR="code"

# Tell grep to highlight matches
#export GREP_OPTIONS='—color=auto'

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

export PAGER='less -r'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# bash autocomplete
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"