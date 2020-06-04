# ohmydot

My personal dotfiles. A work in progress...

## credits

Uses a minimal .bashrc that loads files fom .bashrc.d/ an idea taken from here: https://medium.com/@waxzce/use-bashrc-d-directory-instead-of-bloated-bashrc-50204d5389ff

Name of repo obviously a play on oh-my-zsh, no furter comparision even if i probably have stolen some ideas from plugins found in there...

## install

Clone repo into $HOME, and use [stow](https://www.gnu.org/software/stow/) to install the different "modules"


```
sudo apt install stow
cd $HOME
git clone git@github.com:gdamberg/ohmydot.git .ohmydot
cd .ohmydot
stow ack
stow bash
stow code
stow git
stow tmux
stow vim
stow zsh
```

Proper install script TBD

### customization

For local machine specific stuff put it in $HOME/.bashrc_local, $HOME/.zshrc_local and $HOME/.gitconfig_local

### Install stuff

Common tools
```
sudo apt install ack apt-transport-https curl \
    gnome-tweaks jq meld source-highlight \
    stow tmux tree vim vim-doc vim-scripts \
    xclip
```

#### zsh 
zsh usage is done for oh-my-zsh and powerlevel10k

oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh
Install: 
```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

power10k prompt: https://github.com/romkatv/powerlevel10k
Install: 
```
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Fixes

#### Jetbrains
Problem with inotif. See https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit

 ```
 sudo ln -s $HOME/ohmydot/60-jetbrains.conf /etc/sysctl.d/60-jetbrains.conf
sudo service procps start
```

#### dell xps 15

##### resume after sleep
Had problems resuming after sleep. This helped:
https://wiki.archlinux.org/index.php/Dell_XPS_15_9570#Suspend

An easy way would be to add mem_sleep_default=deep to the GRUB_CMDLINE_LINUX_DEFAULT entry in /etc/default/grub:
```
 GRUB_CMDLINE_LINUX_DEFAULT="mem_sleep_default=deep"
```

After modifying grub file:
```
sudo update-grub
```
##### fans going crazy
In ubuntu 19.10 fans going crazy...

Main offender, Nvidia setting gpu to max performance as default (and resetting this after reboot !)

Add startup application with command: `sh -c '/usr/bin/nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=0"'` to set mode to "adaptive"
