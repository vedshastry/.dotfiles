# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' matcher-list '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle :compinstall filename '/home/ved/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# Set default prompt 
#prompt adam1
PROMPT='%F{white}%n%f@%F{green}%m%f %F{blue}%B%~%b%f %# '
RPROMPT='[%F{yellow}%?%f]'

# Variables
export VISUAL=vim
export EDITOR=vim
export OPENER='rifle'

# Aliases
alias fd='find'
alias v='vim'
alias e='emacsclient -a -c 'emacs''
alias vp='vim -p'
alias sv='sudoedit'
alias p='sudo pacman'
alias reboot='~/scripts/poweroff.sh /sbin/reboot'
alias slp='sudo systemctl suspend'
alias hbn='sudo systemctl hibernate'
#alias reboot='sudo reboot'
alias nixon='sh ~/scripts/whonixon.sh'
alias nixoff='sh ~/scripts/whonixoff.sh'
alias toron='systemctl enable tor.service'
alias toroff='systemctl disable tor.service'
alias g='googler'
alias netre='sudo systemctl restart NetworkManager'
#alias lf='lfrun'
alias zz='sudo zzz'


#a2# Only show dot-directories
alias lad='command ls -d .*(/)'
#a2# Only show dot-files
alias lsa='command ls -a .*(.)'
# ssh into hpcc
alias hpcc='ssh f0101094@hpcc.msu.edu'
alias bipp='ssh bipp4@10.0.96.110'
#neovim
alias nvimrc='nvim ~/.config/nvim/init.vim'
# python virtualenv
alias pyenv='source /home/ved/.local/share/py_virtualenv/bin/activate'
# dwm patching
alias pt='patch -p1 <'
alias dwmc='cd ~/repos/dwm && sudo make clean install'
# stata-wine
alias xst="cd /home/ved/stuff/stata17/Stata17 && wine StataMP-64.exe"
# antibody update plugins - zsh
alias zplug='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'
# leagueoflegends-git
alias lol='leagueoflegends'
# warp
alias won='warp-cli connect'
alias woff='warp-cli disconnect'
alias wre='sudo systemctl restart warp-svc.service'
# cisco anyconnect
alias cvpn='/opt/cisco/anyconnect/bin/vpnui'
# monero
alias mn='monero-wallet-cli'


# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Antibody
source ~/.zsh_plugins.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# pacman reinstall
#inspkg=$(comm -12 <(pacman -Slq | sort) <(sort ~/pacman.lst))
