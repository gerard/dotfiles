# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history and ignore same successive entries
export HISTCONTROL=ignoredups:ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Titlebar of the terminal emulator (executed for each line)
PROMPT_COMMAND='echo -ne "\033]0;${USER}: ${PWD/$HOME/~}\007"'

# enable color support of ls
[ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ] && eval "`dircolors -b`"

# Fix UTF-8 with putty and disable XON/XOFF
echo -ne '\e%G\e[?47h\e%G\e[?47l'
stty -ixon

export EDITOR="vim"
export PATH="$HOME/bin:/usr/lib/ccache:$PATH"
export DEBEMAIL="Gerard Lledó <gerard.lledo@gmail.com>"
export PS1='\h[$?]:\w [$(date +%H:%M)]\$ '
export GDBHISTFILE="$HOME/.gdb_history"
export BASH_COMPLETION_LOCAL="$HOME/.bash_completion.d"

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls'
alias week='date +%V'

# To relieve the pain of editing this files!
alias reload='source ~/.bashrc'
alias editrc='vim ~/.bashrc'
alias editrc_local='vim ~/.bashrc_local'

# SSH Agent
SSH_AGENT_RUN=$HOME/.ssh/ssh-agent.run
SSH_PRIVKEY=$HOME/.ssh/id_rsa
if [ -f $SSH_PRIVKEY -a -f `which ssh-agent` ] && ! killall -0 ssh-agent 2> /dev/null
then
    ssh-agent | grep -v echo > $SSH_AGENT_RUN
    source $SSH_AGENT_RUN
    ssh-add
fi
[ -f $SSH_AGENT_RUN ] && source $SSH_AGENT_RUN

# Machine specific .bashrc (optionally) in another file
[ -f $HOME/.bashrc_local ] && source $HOME/.bashrc_local

# Bash completion
if [ -f /etc/bash_completion ]
then
    source /etc/bash_completion
fi

# User bash completion
if [ -d $BASH_COMPLETION_LOCAL ]
then
    for COMPLETION in $BASH_COMPLETION_LOCAL/*
    do
        source $COMPLETION
    done
fi
