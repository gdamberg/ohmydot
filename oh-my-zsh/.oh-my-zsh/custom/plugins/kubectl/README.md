# Kubectl plugin
My version of the kubectl default oh-my-zsh plugin. Removing many of the default aliases and adding a few of my own

This plugin adds completion for the [Kubernetes cluster manager](https://kubernetes.io/docs/reference/kubectl/kubectl/),
as well as some aliases for common kubectl commands.

To use it, add `kubectl` to the plugins array in your zshrc file:

```zsh
plugins=(... kubectl)
```

## Aliases

| Alias   | Command                             | Description                                                                                      |
|:--------|:------------------------------------|:-------------------------------------------------------------------------------------------------|
| k       | `kubectl`                           | The kubectl command                                                                              |
| ka      | `kubectl $@ --all-namespaces`          | Execute a kubectl command against all namespaces
|
