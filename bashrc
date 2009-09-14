# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

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
#force_colored_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls
[ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ] && eval "`dircolors -b`"

export EDITOR="vim"
export PATH="$HOME/bin:/usr/lib/ccache:$PATH"
export DEBEMAIL="Gerard Lledó <gerard.lledo@gmail.com>"
export PS1='\h[$?]:\w [$(date +%H:%M)]\$ '
export GDBHISTFILE="$HOME/.gdb_history"

# Fix UTF-8 with putty
echo -ne '\e%G\e[?47h\e%G\e[?47l'

# Disable XON/XOFF
stty -ixon

alias ll='ls -l'
alias la='ls -A'
alias l='ls'
alias week='date +%V'

alias reload='source ~/.bashrc'
alias editrc='vim ~/.bashrc'
alias editrc_local='vim ~/.bashrc_local'

[ -f $HOME/.ssh/ssh-agent.run ] && source $HOME/.ssh/ssh-agent.run
[ -f $HOME/.bashrc_local ] && source $HOME/.bashrc_local

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
