# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# Set line editing mode to vi
#set -o vi

########## Alias ##########

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -l'

alias zh_locale='
LC_ALL=zh_TW.utf8
LANG=zh_TW.utf8
LANGUAGE=zh_TW.utf8
LC_MESSAGE=zh_TW.utf8
LC_TIME=zh_TW.utf8'

alias en_locale='
LC_ALL=en_US.utf8
LANG=en_US.utf8
LANGUAGE=en_US.utf8
LC_MESSAGE=en_US.utf8
LC_TIME=en_US.utf8'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

########## Environment Variables ##########

# PATH
export PATH=$HOME/bin:/sbin:/usr/bin/vendor_perl:/opt/java/bin:/usr/share/java/apache-ant/bin/:$HOME/bin/matlab.d:/usr/lib/colorgcc/bin:$HOME/.rvm/bin:$PATH

# Default App
export EDITOR=vim

export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# PS1
export PS1="\[\e[1;37m\][\[\e[0m\]\[\e[1;33m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\]\[\e[1;37m\]]\$\[\e[0m\] "

# Change Locale to en_US.utf8
en_locale

# Pre-prompt callback
pre_prompt() {
  status=`git status 2> /dev/null`
  check=`echo $status | grep -i 'branch'`
  cancommit=`echo $status | grep -i 'to be committed'`
  notstage=`echo $status | grep -i 'not staged'`

  if [ -n "$check" ]; then
    if [[ "$check" == *Not*branch* ]]; then
      branch='none'
    else
      branch=`echo $check | cut -d ' ' -f 4`
    fi
    if [ -n "$notstage" ]; then
      branch=$branch*
    elif [ -n "$cancommit" ]; then
      branch=$branch#
    fi
    export PS1="\[\e[1;37m\][\[\e[0m\]\[\e[1;33m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \[\e[1;32m\]($branch)\[\e[0m\]\[\e[1;37m\]]\$\[\e[0m\] "
  else
    export PS1=$PS1_ORIG
  fi
}

export PS1_ORIG=$PS1
export PROMPT_COMMAND=pre_prompt
