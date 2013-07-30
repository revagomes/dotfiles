#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1: returns current rvm gemset
function __rvm_ps1() {
  local gemset_is_loaded rvmprompt
    # if there is a gemset loaded
    # then there is a separator (usually an @ symbol)
    gemset_is_loaded="$(rvm-prompt | grep @)"
    if [ -n "$gemset_is_loaded" ]; then
      # following string operator trims greedily up to last @
      echo "(${gemset_is_loaded##*@}) "
    else
      exit
    fi
}

# PS1='`__rvm_ps1`\w`__git_ps1` $ '
PS1='\[\e[1;34m\]`__rvm_ps1`\w\[\e[m\]\[\e[0;31m\]`__git_ps1` $ \[\e[m\]'

# ubuntu: load aliases from .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ubuntu: check window size after each command
shopt -s checkwinsize

# archwiki: prevent repeated commands on history
export HISTCONTROL=ignoredups

# ubuntuforums: leave some commands out of history log
export HISTIGNORE="&:??:[ ]*:clear:exit:logout"

# revagomes: set vim as editor
export EDITOR=vim

# archwiki: run keygen to automatically add ssh
eval `keychain --eval --agents ssh id_rsa --quiet`

# groucho: ~/.local/bin in path
PATH=$HOME/.local/bin:$PATH

# groucho: drush shortcuts
function drush-dlen () { drush dl $1 && drush en $1 --yes; }
function drush-undis () { drush dis $1 --yes && drush pm-uninstall $1 --yes; }

# commandlinefu: watch from youtube in mplayer
function yt () { mplayer -fs -quiet $(youtube-dl -g "$1"); }

if [ -f /etc/debian_version ]; then
 . /etc/bash_completion
fi

# nuvoleweb: load aliases from .drush_aliases
if [ -f ~/.drush_aliases ]; then
    . ~/.drush_aliases
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # startup virtualenv-burrito
    if [ -f "$HOME/.venvburrito/startup.sh" ]; then
        . "$HOME/.venvburrito/startup.sh"
    fi
fi

# pip: create virtualenvs in workon home
export PIP_VIRTUALENV_BASE=$WORKON_HOME

#perlbrew: source the perlbrew
#source ~/perl5/perlbrew/etc/bashrc

# nvm: source the nvm.sh
#source ~/.local/opt/nvm/nvm.sh

# rvm: add rvm to the path
PATH=$PATH:$HOME/.rvm/bin

# This loads RVM into a shell session.
[[ -s "/home/revagomes/.rvm/scripts/rvm" ]] && source "/home/revagomes/.rvm/scripts/rvm"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

#Selenium: Chromium WebDriver
PATH=$PATH:/opt/seleniumChromium

alias dr="drush"

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Directory navigation aliases
alias ..='cd ..'
alias ...='..;..'
alias ....='..;..;..'
alias .....='..;..;..;..'
alias ......='..;..;..;..;..'



# Extracting files

extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Dev functions

www () {
  cd "$(_www_root)$1"
}

_www_root () {
  echo '/var/www/'
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w:$(__git_ps1)\[\033[00m\]\$ '

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local   DARK_BLUE="\[\033[0;34m\]"
  local  LIGHT_BLUE="\[\033[1;36m\]"
  local        BLUE="\[\033[1;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local   C_DEFAULT="\[\033[m\]"
  local     C_WHITE="\[\033[1m\]"
  local     C_BLACK="\[\033[30m\]"
  local       C_RED="\[\033[31m\]"
  local C_GREEN="\[\033[32m\]"
  local C_YELLOW="\[\033[33m\]"
  local C_BLUE="\[\033[34m\]"
  local C_PURPLE="\[\033[35m\]"
  local C_CYAN="\[\033[36m\]"
  local C_LIGHTGRAY="\[\033[37m\]"
  local C_DARKGRAY="\[\033[1;30m\]"
  local C_LIGHTRED="\[\033[1;31m\]"
  local C_LIGHTGREEN="\[\033[1;32m\]"
  local C_LIGHTYELLOW="\[\033[1;33m\]"
  local C_LIGHTBLUE="\[\033[1;34m\]"
  local C_LIGHTPURPLE="\[\033[1;35m\]"
  local C_LIGHTCYAN="\[\033[1;36m\]"
  local C_BG_BLACK="\[\033[40m\]"
  local C_BG_RED="\[\033[41m\]"
  local C_BG_GREEN="\[\033[42m\]"
  local C_BG_YELLOW="\[\033[43m\]"
  local C_BG_BLUE="\[\033[44m\]"
  local C_BG_PURPLE="\[\033[45m\]"
  local C_BG_CYAN="\[\033[46m\]"
  local C_BG_LIGHTGRAY="\[\033[47m\]"
#  case $TERM in
#    xterm*)
#    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
#    ;;
#    *)
#    TITLEBAR=""
#    ;;
#  esac

#PS1="${TITLEBAR}\
PS1="$DARK_BLUE[$GREEN\$(date +%H:%M)$DARK_BLUE]\
$DARK_BLUE[$RED\u@\h$DARK_BLUE:$BLUE\w$GREEN\$(parse_git_branch)$DARK_BLUE]\
\n$LIGHT_GREEN\$ $LIGHT_GRAY"
PS2='> '
PS4='+ '
}
proml

force_color_prompt=yes
