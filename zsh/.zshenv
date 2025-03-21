# shell
export SHELL=zsh

# editor
export VISUAL=nvim
export EDITOR=nvim

# file opener
export OPENER=rifle

# browser
export BROWSER=zen-browser

# pdf viewer
export PDFVIEWER=zathura

# path variable
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/stata18:$PATH
export PATH=$HOME/scripts:$PATH
export PATH=$HOME/ado:$PATH
export PATH=/opt/android-sdk/platform-tools:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH

# python virtual environment
export PIPENV_PATH=$HOME/.local/share/py_virtualenv

# ruby gems home dir
export PATH=$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH
export GEM_HOME="$HOME/.local/share/gem/ruby/3.0.0"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# Stata path
export PATH="$PATH:/usr/local/stata18/stata-mp"
# pulsar dir
#export ATOM_HOME="~/.atom"
