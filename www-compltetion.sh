#!/bin/bash

# BASH completion script for www function.
#
# You must run this script as root in order to be able to create the _www file in the /etc/bash_completion.d/ directory.

if [ ! -f /etc/bash_completion.d/_www ]; then
  printf '_www() {\nlocal dirs=("/www/$2"*/); [[ -e ${dirs[0]} ]] && COMPREPLY=( "${dirs[@]#/www/}" );\n}' >> /etc/bash_completion.d/_www;
fi
grep -qs _www /etc/bash_completion
if [ $? -eq 1 ]; then
  printf "complete -F _www www\n" >> /etc/bash_completion;
fi
if [ -f ~/.bashrc ]; then
   . ~/.bashrc
 else
  echo "You are not using a .bashrc file please reopen the console in order to get the www completion working."
fi
