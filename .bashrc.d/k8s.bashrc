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

# code completion kubectx/kubens
if [ -e $HOME/projects/github/kubectx ]; then
    source $HOME/projects/github/kubectx/completion/kubectx.bash
    source $HOME/projects/github/kubectx/completion/kubens.bash
fi

function minikube-attach() {
    eval $(minikube docker-env)
}
function minikube-detach() {
    eval $(minikube docker-env --unset)
}
