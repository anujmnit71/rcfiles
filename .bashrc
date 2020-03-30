# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=200000
##########################################################################
#
# Use case-insensitive filename globbing
shopt -s nocaseglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Don't wait for job termination notification
set -o notify

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export KAFKA_HOME='/home/anujkumar/work/software/kafka_2.11-2.0.0/bin'
export CCLOUD_HOME='/home/anujkumar/work/software/ccloud-0.2.1/bin'
export JAVA_HOME='/home/anujkumar/work/software/jdk-8u181-linux-x64/jdk1.8.0_181/'
export JDK_HOME='/home/anujkumar/work/software/jdk-8u181-linux-x64/jdk1.8.0_181/bin'
#export JAVA_HOME='/home/anujkumar/work/software/jdk/jdk-10_linux-x64_bin_ri/jdk-10'
#export JDK_HOME='/home/anujkumar/work/software/jdk/jdk-10_linux-x64_bin_ri/jdk10/bin'
export INTELLIJ_HOME='/home/anujkumar/work/software/intellij_idea/bin'
export GHZPATH='/home/anujkumar/work/software/ghz'
export GOROOT='/usr/local/go'
export GOPATH='/home/anujkumar/work/miq/platform-svc-commons/apigateway/gospace'
export PIP_DOWNLOAD_CACHE=/home/anujkumar/.pip_download_cache
export GRADLE_HOME='~/work/software/gradle_55/gradle-5.5'
export PYIDE_HOME='/home/anujkumar/work/software/pycharm-community-2019.3.2/bin'
export ECLIPSE_CPP_HOME='/home/anujkumar/work/software/eclipse_cpp'
export PIP_HOME='/home/anujkumar/.local/bin'
export M2_HOME='/home/anujkumar/work/software/apache-maven-3.5.4'
export M2=$M2_HOME/bin
export MAVEN_OPTS='-Xms256m -Xmx1024m'
# some more ls aliases
export PATH=$PATH:$KAFKA_HOME:$JAVA_HOME:$CCLOUD_HOME:$JDK_HOME:$INTELLIJ_HOME:$GOPATH:$GOPATH/bin:$GOROOT/bin:$GHZPATH:${GRADLE_HOME}/bin:$PYIDE_HOME:$ECLIPSE_CPP_HOME:$PIP_HOME:$M2

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
. /etc/bash_completion
fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

#Acquire::http::proxy "http://10.116.2.243:80/";
#Acquire::https::proxy "https://10.116.2.243:80/";
