# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory notify prompt_subst completeinword
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
autoload -Uz compinit
compinit
# End of lines added by compinstall

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# report the status of backgrounds jobs immediately
setopt notify

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# Auto-complete settings
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _correct _complete:foo
zstyle ':completion:*:complete:*' matcher-list \
    '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:foo:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z} r:|[-_./]=* r:|=*'
hosts=(`hostname`)
zstyle '*' hosts $hosts
# use ~/.ssh/known_hosts for completion
[ -f "$HOME/.ssh/known_hosts" ] && \
    hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*}) && \
    zstyle ':completion:*:hosts' hosts $hosts

alias ls='ls --color=auto'
#alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
#alias la='ls -A'
#alias ii='ls -l'
#alias ia='ls -A'
#alias i='ls -C'
alias grep='grep --color=auto'
alias g='grep --color=auto'

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "*"
zstyle ':vcs_info:*' stagedstr "#"
zstyle ':vcs_info:*' formats ' (%b%u%c)'
zstyle ':vcs_info:*' actionformats ' (%b%u%c) {%a}'


precmd () { vcs_info }
EXITCODE="%(?..%?%1v )"
JOBS="%(1j.%j .)"
local BLUE="%{[1;34m%}"
local RED="%{[1;31m%}"
local GREEN="%{[1;32m%}"
local CYAN="%{[1;36m%}"
local YELLOW="%{[1;33m%}"
local WHITE="%{[1;37m%}"
local MAGENTA="%{[1;35m%}"
local NO_COLOUR="%{[0m%}"

local HOST_COLOR=$YELLOW
local USER_COLOR=$YELLOW

if [[ `whoami` == 'root' ]]; then
  USER_COLOR=$RED
fi
if [[ `hostname` != 'azslaptop' ]]; then
  HOST_COLOR=$GREEN
fi

PROMPT="${WHITE}[${RED}${EXITCODE}${CYAN}${JOBS}${MAGENTA}%* ${USER_COLOR}%n${YELLOW}@${HOST_COLOR}%m:${BLUE}%40<...<%B%~%b%<<"${GREEN}'${vcs_info_msg_0_}'${WHITE}]"
${GREEN}%# ${NO_COLOUR}"

# For stupid Tramp mode
if [ "$TERM" = "dumb" ]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi

# Some env
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Go
export GOPATH=$HOME/go

# PATH
export PATH=/opt/homebrew/bin:$HOME/.cargo/bin:$HOME/bin:/usr/lib/colorgcc/bin:/sbin:/usr/sbin:$HOME/.rvm/bin:$GOPATH/bin:$PATH

export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    nvim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# Locale switching
alias zh_locale='
export LC_ALL=zh_TW.UTF-8
export LANG=zh_TW.UTF-8
export LANGUAGE=zh_TW.UTF-8
export LC_MESSAGE=zh_TW.UTF-8
export LC_TIME=zh_TW.UTF-8'

alias en_locale='
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_MESSAGE=en_US.UTF-8
export LC_TIME=en_US.UTF-8'

en_locale

# Evironment
export EDITOR=nvim
export BROWSER=google-chrome-beta
export TERM=xterm-256color

# Zsh plugins
ZSH_DIR=$HOME/bin/zsh
[ -f $ZSH_DIR/zsh-syntax-highlighting.git/zsh-syntax-highlighting.zsh ] && source $ZSH_DIR/zsh-syntax-highlighting.git/zsh-syntax-highlighting.zsh
[ -f $ZSH_DIR/zsh-autosuggestions.git/zsh-autosuggestions.zsh ] && source $ZSH_DIR/zsh-autosuggestions.git/zsh-autosuggestions.zsh
[ -f $ZSH_DIR/kubectl.plugin.zsh ] && source $ZSH_DIR/kubectl.plugin.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Misc plugins
source $HOME/bin/autojump.git/bin/autojump.zsh

# Misc alias
alias vim=nvim
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
