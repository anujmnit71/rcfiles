#!/bin/bash 
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ffprobe='ffprobe -hide_banner'

# some more ls aliases
alias ls='ls --color=auto -1'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias docker='sudo docker'
alias stripcolor='cat "$@" | sed -r "s/\x1B\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"'

workdir='/home/anujkumar/work'

cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  limit=15
  popd -n +$limit 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= $limit; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}
 
alias cd=cd_func

# Functions
#
# Some people use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi
#
# Some example functions:
#
# a) function settitle
settitle () 
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

extract () {
   if [ -f $1 ] ; then
       case $1 in
	*.tar.bz2)	tar xvjf $1 && cd $(basename "$1" .tar.bz2) ;;
	*.tar.gz)	tar xvzf $1 && cd $(basename "$1" .tar.gz) ;;
	*.tar.xz)	tar Jxvf $1 && cd $(basename "$1" .tar.xz) ;;
	*.bz2)		bunzip2 $1 && cd $(basename "$1" /bz2) ;;
	*.rar)		unrar x $1 && cd $(basename "$1" .rar) ;;
	*.gz)		gunzip $1 && cd $(basename "$1" .gz) ;;
	*.tar)		tar xvf $1 && cd $(basename "$1" .tar) ;;
	*.tbz2)		tar xvjf $1 && cd $(basename "$1" .tbz2) ;;
	*.tgz)		tar xvzf $1 && cd $(basename "$1" .tgz) ;;
	*.zip)		unzip $1 && cd $(basename "$1" .zip) ;;
	*.Z)		uncompress $1 && cd $(basename "$1" .Z) ;;
	*.7z)		7z x $1 && cd $(basename "$1" .7z) ;;
	*)		echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

function open_intellij {
	pushd ~/work/software/intellij_idea/bin/
	./idea.sh >& intellij.log &
	popd
}
function open_postman {
	pushd ~/work/software/Postman706/Postman/
	./Postman >& /dev/null &
	popd
}
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
git_fetch_log() {
    fmt='ref=%(refname:short); up=%(upstream:short); t=%(upstream:track); ts=%(upstream:trackshort);'
    git for-each-ref --shell --format="$fmt" refs/heads | \
    while read entry; do
      eval "$entry"
      if test "z$ts" != 'z' && test "z$ts" != 'z='; then
        echo -e "\n==== $ref $t\n"
        git log --graph --left-right --decorate --abbrev-commit --date-order --boundary $@ $ref...$up
      fi
    done
}
#Map prtscr and insert to Home and End
#run this  to generate .Xmodmap
#  xmodmap -pke >~/.Xmodmap
xmodmap -e "keycode 107 = Home"
xmodmap -e "keycode 118 = End"

hr(){ printf '%0*d' $(tput cols) | tr 0 ${1:-_}; }

single-monitor() {
  echo xrandr --output $3 --off xrandr --output $1 --mode $2
  xrandr --output $3 --off && xrandr --output $1 --mode $2
}

multi-monitor() {
  echo xrandr --output $1 --mode $2 --output $3 --mode $4 --left-of $1 $5
  xrandr --output $1 --mode $2 --output $3 --mode $4 --left-of $1 $5
}
