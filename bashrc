# vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history and ignore same successive entries
export HISTCONTROL=ignoredups:ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Titlebar of the terminal emulator (executed for each line). Avoid ttys.
HOST=`hostname | cut -d. -f1`
[ $TERM != linux ] && PROMPT_COMMAND='echo -ne "\033]0;${USER}@$HOST: ${PWD/$HOME/~}\007"'

# enable color support of ls
[ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ] && eval "`dircolors -b`"

# Fix UTF-8 with putty and disable XON/XOFF
echo -ne '\e%G\e[?47h\e%G\e[?47l'
stty -ixon

# Eventually I need to use this so when testing my fuse app I don't get more FS
# reads than necessary for each prompt line.
ps1_git_branch() {
    if [ "$1" == "on"  ]
    then
        function __parse_git_branch() {
            # Notice the 3rd sed expression that shortens branch names that
            # start with a number and an underscore.
            git branch 2> /dev/null | sed -e '/^[^*]/d' \
                                          -e 's/* \(.*\)/\1/' \
                                          -e 's/^\([1-9][0-9]*\)_.*/\1/' \
                                          -e 's/^\(.*\)/:\1/'
        }
    fi

    if [ "$1" == "off" ]
    then
        function __parse_git_branch() {
            true
        }
    fi
}

ps1_git_branch on

# Needed for PS1
[ -f $HOME/.bash/colors ] && source $HOME/.bash/colors

export EDITOR="vim"
export GIT_EDITOR="$EDITOR"
export DEBEMAIL="Gerard Lledó <gerard.lledo@gmail.com>"
export PS1="$(ps1_color_echo $COLOR_txtgrn \\h)"'[$?]$(__parse_git_branch):\w [$(date +%H:%M)]\$ '

export GDBHISTFILE="$HOME/.gdb_history"
export BASH_COMPLETION_LOCAL="$HOME/.bash_completion.d"

unalias -a
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls'
alias week='date +%V'
alias mutt-local='mutt -F /dev/null'
function settabname {
    SET_TO=$1

    [ $TERM != "screen" ] && return 0
    [ $# -eq 0 ] && SET_TO=`basename $SHELL`

    echo -ne "\ek$SET_TO\e\\"
}

# Useful to avoid verbose output on scripts
alias spushd='pushd > /dev/null'
alias spopd='popd > /dev/null'

alias reload="pushd $HOME > /dev/null && source ~/.bashrc && popd > /dev/null"

# To relieve the pain of editing this files!
alias editrc='vim ~/.bashrc'
alias editrc_local='vim ~/.bashrc_local'

# Jumps
[ -f $HOME/.bash/jumps ] && source $HOME/.bash/jumps
[ -f $HOME/.bash/mssh ] && source $HOME/.bash/mssh
[ -f $HOME/.bash/ide ] && source $HOME/.bash/ide

# Only load this if we actually have subversion installed
if which svn > /dev/null
then
    [ -f $HOME/.bash/svn ] && source $HOME/.bash/svn
fi

if which keychain > /dev/null
then
    keychain -q
    . ~/.keychain/$HOSTNAME-sh
    . ~/.keychain/$HOSTNAME-sh-gpg
else
    echo "W: keychain is not installed.  No sane ssh-agent support available."
fi

# Machine specific .bashrc (optionally) in another file
[ -f $HOME/.bashrc_local ] && source $HOME/.bashrc_local

# Bash completion
if [ -f /etc/bash_completion ]
then
    source /etc/bash_completion
fi

# User bash completion
if [ -d $BASH_COMPLETION_LOCAL -a $BASH_VERSINFO -ge 3 ]
then
    for COMPLETION in $BASH_COMPLETION_LOCAL/*
    do
        source $COMPLETION
    done
fi

### PATHADD STARTING ###
function pathadd {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathadd "$HOME/bin"
pathadd "/usr/lib/ccache"

[ -f $HOME/.bashrc_local_pathadd ] && . $HOME/.bashrc_local_pathadd
unset pathadd
### PATHADD ENDING: No more PATH modification ###

# Clean up $OLDPWD
OLDPWD=$HOME
