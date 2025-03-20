#!/bin/sh

# function to launch a program if it is not already running
function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}


run	"nitrogen --restore"
# Keymap
run	"setxkbmap us"
# Picom
run	"picom" 
run	"xsetroot -cursor_name left_ptr"
# Wallpaper
run	"nitrogen --restore"
# Fonts
#run	"xset +fp ~/.fonts/misc"
# Pulseaudio
run	"pulseaudio --start"
# Numlock
run	"numlockx"
# Dunst notify
run	"dunst"
# KeepassXC
run	"keepassxc"
# Syncthing
run	"syncthing -no-browser -no-restart -logflags=3"
# Network manager applet
run	"nm-applet"
# Power Manager
run	"xfce4-power-manager"
# Solaar
run	"solaar"
# Bluetooth
run	"blueman-applet"
# Audio
run	"pasystray"
# Dropbox
run	"dropbox"
#run	"maestral"
# Onedrive systray
#run	"onedrive_tray"
# Slack
run 	"slack -u"
# Teams
#run 	"teams"
# Flameshot 
run	"flameshot"
# Redshift 
#run	"redshift-gtk"
# Emacs daemon
run "emacs --daemon"
# Slstatus
run	"slstatus"
# touchegg
run "touchegg --daemon"
run "touchegg"
