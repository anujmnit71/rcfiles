#!/bin/bash 
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gdb='/drives/e/anuj_hd_data/software/mingw-w64/x86_64/mingw64/bin/gdb.exe'
alias g++='/drives/e/anuj_hd_data/software/mingw-w64/x86_64/mingw64/bin/g++.exe'
alias gcc='/drives/e/anuj_hd_data/software/mingw-w64/x86_64/mingw64/bin/gcc.exe'
alias g++11='g++ -std=c++11'
alias g++14='g++ -std=c++14'

winhome='/drives/c/Users/anuj_k_Verma'
alias 7z='/drives/c/SoftwareInstall/7-Zip/7z.exe'
alias notepad++='/drives/c/SoftwareInstall/Notepad++/notepad++.exe'
alias git='/drives/c/SoftwareInstall/PortableGit/bin/git.exe'
alias mvn='mvn.cmd'
alias python27='/drives/C/SoftwareInstall/Python27/python.exe'
alias python34='/drives/C/SoftwareInstall/Python34/python.exe'
alias pip27='/drives/c/SoftwareInstall/Python27/Scripts/pip.exe'
alias WinMergeU='/drives/c/SoftwareInstall/WinMerge/WinMergeU.exe'
function open_opengrok {
	pushd /drives/e/grokit-master_working/src/
	python27 grokit.py --action=start
	popd
}

function open_eclipse_cpp {
	pushd /drives/e/anuj_hd_data/eclipse-cpp-mars-2-win32-x86_64/eclipse
	./eclipse.exe &
	popd
}

function open_eclipse_java {
	pushd /drives/e/anuj_hd_data/eclipse-jee-mars-2-win32-x86_64/eclipse
	./eclipse.exe &
	popd
}

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
  popd -n +15 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 15; cnt++)); do
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
