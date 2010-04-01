export PATH="$HOME/bin:$HOME/.bin:/usr/lib/ccache:$PATH"
export ROOT_LOCAL=$HOME/local
export ORIG_PATH=$PATH

if [ -d $ROOT_LOCAL ]
then
    export PATH="$ROOT_LOCAL/bin:$PATH"
    export PERL5LIB=$ROOT_LOCAL/lib/perl5
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history and ignore same successive entries
export HISTCONTROL=ignoredups:ignoreboth

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

__parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/:\1/'
}
export EDITOR="vim"
export GIT_EDITOR="$EDITOR"
export DEBEMAIL="Gerard Lledó <gerard.lledo@gmail.com>"
export PS1='\h[$?]$(__parse_git_branch):\w [$(date +%H:%M)]\$ '
export GDBHISTFILE="$HOME/.gdb_history"
export BASH_COMPLETION_LOCAL="$HOME/.bash_completion.d"

unalias -a
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls'
alias week='date +%V'
alias mutt-local='mutt -F /dev/null'

# Useful to avoid verbose output on scripts
alias spushd='pushd > /dev/null'
alias spopd='popd > /dev/null'

alias reload="pushd $HOME > /dev/null && source ~/.bashrc && popd > /dev/null"

# To relieve the pain of editing this files!
alias editrc='vim ~/.bashrc'
alias editrc_local='vim ~/.bashrc_local'

# To relieve the pain of using SVN
if which svn > /dev/null
then
    REAL_SVN=`which svn`
    function svn {
        case $1 in
        clean)
            $REAL_SVN status | grep ^? | tr -s ' ' | cut -d\  -f2- | xargs -d \\n rm -rf
            ;;
        log)
            $REAL_SVN $* | less
            ;;
        blame)
            $REAL_SVN $* | less
            ;;
        diff)
            DIFF_CMD="diff"
            $REAL_SVN diff --diff-cmd=$DIFF_CMD $* | less -R
            ;;
        *)
            $REAL_SVN $*
            ;;
        esac
    }
fi

# We use this to find the closest cscope.out
function vim {
    REALVIMARGS="$*"

    # Skip parameters to vim
    while [[ $1 =~ '^\+' ]] || [[ $1 =~ '^\-' ]]
    do
        shift
    done

    FILEDIR=$PWD
    [ -n "$1" ] && FILEDIR=$FILEDIR/`dirname $1`

    REALVIM=`which vim`

    # Maybe add a check so we don't do this for files that are not indexed
    # using cscope?

    # Iterate from the current directory to the root.  We miss /cscope.out,
    # which is not that common (or sane) place to store it.
    DIR=$FILEDIR
    while [ -z "$CSCOPE_DB" ] && [ $DIR != "/" ]
    do
        if [ -e $DIR/cscope.out ]
        then
            export CSCOPE_DB=$DIR/cscope.out
            break
        fi
        DIR=`dirname $DIR`
    done
    echo "[$$] Using cscope: $CSCOPE_DB"

    # Same thing for ctags
    DIR=$FILEDIR
    while [ $DIR != "/" ]
    do
        if [ -e $DIR/tags ]
        then
            export CTAGS_DB=$DIR/tags
            break
        fi
        DIR=`dirname $DIR`
    done
    echo "[$$] Using ctags:  $CTAGS_DB"

    $REALVIM $REALVIMARGS
}

# Jumps
[ -f $HOME/.bash/jumps ] && source $HOME/.bash/jumps
[ -f $HOME/.bash/mssh ] && source $HOME/.bash/mssh

# SSH Agent
SSH_AGENT_RUN=$HOME/.ssh/ssh-agent.run
SSH_PRIVKEY=$HOME/.ssh/id_rsa
if [ -f $SSH_PRIVKEY ] && which ssh-agent > /dev/null && ! killall -0 ssh-agent 2> /dev/null
then
    ssh-agent | grep -v echo > $SSH_AGENT_RUN
    source $SSH_AGENT_RUN
    ssh-add
fi

[ -f "$SSH_AGENT_RUN" ] && source $SSH_AGENT_RUN

# Machine specific .bashrc (optionally) in another file
[ -f $HOME/.bashrc_local ] && source $HOME/.bashrc_local

# Bash completion
if [ -f /etc/bash_completion ]
then
    source /etc/bash_completion
fi

# TODO: Figure out what the have command is (ie, used in debconf completion)
GIT_COMPLETION=/etc/bash_completion.d/git
if [ -f $GIT_COMPLETION ]
then
    source $GIT_COMPLETION
fi

# User bash completion
if [ -d $BASH_COMPLETION_LOCAL -a $BASH_VERSINFO -ge 3 ]
then
    for COMPLETION in $BASH_COMPLETION_LOCAL/*
    do
        source $COMPLETION
    done
fi

# Clean up $OLDPWD
cd
cd
