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

# Aliases
alias p='sudo pacman'
alias vim='nvim'
alias v='nvim'
alias vp='nvim -p'
alias sv='sudo nvim'
alias fd='find'
alias reboot='~/scripts/poweroff.sh /sbin/reboot'
alias slp='sudo systemctl suspend'
alias toron='systemctl enable tor.service'
alias toroff='systemctl disable tor.service'
alias netre='sudo systemctl restart NetworkManager'
alias zz='sudo zzz'

#a2# Only show dot-directories
alias lad='command ls -d .*(/)'
#a2# Only show dot-files
alias lsa='command ls -a .*(.)'

# ssh
#alias hpcc='ssh f0101094@hpcc.msu.edu'
#alias bipp='ssh bipp4@10.0.96.110'

# neovim
alias nvimrc='nvim ~/.config/nvim/init.vim'
# python virtualenv
alias pyenv='source /home/ved/.local/share/py_virtualenv/bin/activate'

# dwm patching and compile
alias pt='patch -p1 <'
alias dwmc='cd ~/repos/dwm && sudo make clean install'

# antibody update plugins - zsh
alias zplug='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'

# warp
alias won='warp-cli connect'
alias woff='warp-cli disconnect'
alias wre='sudo systemctl restart warp-svc.service'

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# rsync
# rsync -aAXlP --exclude={"*cache*","*Cache*","*Dropbox*"} /home/ved/ /backup/dir/
