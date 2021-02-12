# marks
_completemarks() {
	reply=("${MARKPATH:-${HOME}/.marks}"/{,.}*(@N:t))
}
compctl -K _completemarks jump
compctl -K _completemarks unmark

# aws cli
if command -v aws_completer &> /dev/null; then
  complete -C aws_completer aws
fi