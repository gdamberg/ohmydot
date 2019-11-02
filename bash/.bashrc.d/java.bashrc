# jenv
if [ -d $HOME/.jenv ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi
# gradle
export PATH="$PATH:/opt/gradle/current/bin"
# maven
export PATH="$PATH:/opt/maven/current/bin"
export M2_HOME=/opt/maven/current
# groovy
export PATH="$PATH:/opt/groovy/current/bin"
