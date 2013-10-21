# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [ -z "$PS1" ] 
then
	echo Non-Interactive shell >&2
	return
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


#SW=~/projects/cm/trunk/sw/
#QA=~/projects/cm/trunk/qa/
#UP=~/projects/cm/updates/
#CMU=~/projects/cm/trunk/sw/cmuserver/djangoserver
#alias cdqa="cd $QA"
#alias cdsw="cd $SW"
#alias cdup="cd $UP"
#alias cdcmu="cd $CMU"
#
#alias svnup="svn up $SW; svn up $QA"
#alias svnst="svn st $SW; echo 'QA'; svn st $QA"

alias rgrep='grep -RI --exclude-dir=.svn --exclude-dir=*.prj_files'       # Recursive grep ignoring svn files
alias cgrep='rgrep --include=*.{c,cpp,h,py}'

# Use find to ignore symlinks
sgrep ()
{

    local repo_ign="-name .git -o -name .svn" 
    find . \( -type d -a \( $repo_ign \) \) -prune -o -type f -exec grep -H --color $@ {} \;
}

alias g='gvim --remote-silent'

MAKE=/usr/bin/make
if [ -e /usr/bin/colormake ]; then
    # https://github.com/pagekite/Colormake
    MAKE=/usr/bin/colormake;
fi

# Compile using 4 cores, if failed remake with 1 core to show errors
makej4 ()
{
    time $MAKE -j 7 "$@" || (echo "FAILED" && $MAKE "$@")
}
alias make=makej4

# http://linuxdeveloper.blogspot.com/2012/10/building-linux-kernel-clean-way.html
# $cd linux-3.6
# $make distclean
# $make defconfig O=`kb`
# $make O=`kb`
pb ()
{
    local P="~/projects/build/$(basename $(pwd))"
    local branch="_$(git branch)" || branch=''
    P=$P$branch
    mkdir -p $P
    echo $P
}

alias scpbrcm="ssh brcm34 pkill brcm; scp ~/bin-arm/* brcm34:bin/"
alias killcelery='ps auxww | awk " /celery/ {print \$2}" | xargs kill -9'

export EDITOR=vim

alias markcscopedb='export CSCOPE_DB=`pwd`'

function buildenv()
{
	local tt=$1
	if [ ! -z "$TARGET_SYS" ]
	then
		echo "Target sys already set..."
		tt=""
	fi
	case "$tt" in
	dm36x|l138|L138|oe2008)
		echo Setting up CL MityOMAP-L138 Build environment...
		. /usr/local/angstrom/arm/environment-setup
		alias makearm="make ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi-"
		export CCACHE_DIR="$HOME/.ccache_arm-angstrom-linux-gneuabi"
		export PATH="/usr/lib/ccache:$PATH"
		;;

	oe2010)
		echo Setting up CL MityOMAP-L138 OE 2010 Build environment...
		. /usr/local/oecore-i686/environment-setup-armv5te-angstrom-linux-gnueabi
		;;

	am335x|AM335X)
		echo Setting up CL MityARM-AM335X Build environment...
		. /usr/local/ti-sdk-am335x-evm-05.03.02.00/linux-devkit/environment-setup
		#. /usr/local/ti-sdk-am335x-evm/linux-devkit/environment-setup
		#. /usr/local/ti-sdk-am335x-evm-05.07.00.00/linux-devkit/environment-setup
		alias makearm="make ARCH=arm CROSS_COMPILE=arm-arago-linux-gnueabi-"
		export CCACHE_DIR="$HOME/.ccache_arm-arago-linux-gneuabi"
		export PATH="/usr/lib/ccache:$PATH"
		;;
	timesys)
		echo Setting up MityARM-AM335X Timesys build environment
		export PATH=/home/mitydsp/timesys/mityarm_335x/toolchain/ccache:/home/mitydsp/timesys/mityarm_335x/toolchain/bin:$PATH
		alias makearm="make ARCH=arm CROSS_COMPILE=armv7l-timesys-linux-gnueabi-"
		;;
	*)
		echo "Toolchain TARGET_SYS = $TARGET_SYS"
		;;
	esac
}

isMounted()
{
    local mountPT=$1
    mountpoint -q $mountPT
    return $?
}

waitForMount()
{
    local mountPT=$1
    while ! isMounted $mountPT; do
	sleep .5
    done
}

alias cpuimage='echo Insert SD Card; waitForMount /media/boot && cp arch/arm/boot/uImage /media/boot/ && umount /dev/sdb{1..3}; mount'
alias makeu='makearm uImage'
alias gitk='gitk -n 10000'
alias gcp='git cherry-pick -xs'

#Save history immediately
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

#CCACHE
export CCACHE_DIR="$HOME/.ccache"
export PATH="/usr/lib/ccache:$PATH"

QMAKESPEC=/usr/local/ti-sdk-am335x-evm-05.07.00.00/linux-devkit/arm-arago-linux-gnueabi/usr/share/qtopia/mkspecs/linux-g++;export QMAKESPEC; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - AB1C36D0-2B62-930A-B1CF-1B15CF69BE47 F5B7D4D6-21B6-393F-0929-39B2C5CE5B56

QMAKESPEC=/usr/local/ti-sdk-am335x-evm-06.00.00.00/linux-devkit/arm-arago-linux-gnueabi/usr/share/qtopia/mkspecs/linux-g++;export QMAKESPEC; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - AB1C36D0-2B62-930A-B1CF-1B15CF69BE47 799A5755-0755-FE0C-9F76-A336F294C7FA

source ~/.completion
