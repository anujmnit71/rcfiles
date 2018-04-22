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
