#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# The following variable defines the session which is started if the user doesn't explicitly select a session
# Source: http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample

export XMODIFIERS="@im=gcin"
export GTK_IM_MODULE="gcin"
export QT_IM_MODULE="gcin"

source /etc/X11/xinit/xinitrc.d/30-dbus

eval `gnome-keyring-daemon --start`
export GPG_AGENT_INFO SSH_AUTH_SOCK

xset dpms 1800 1800 1800
xset s off
exec awesome
