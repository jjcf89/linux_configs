# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [ -z "$PS1" ] 
then
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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
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

set_old_ps()
{
    export PROMPT_COMMAND="$OLD_PROMPT_COMMAND"

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
}

test_powerline-shell()
{
    ~/.powerline-shell.py 1> /dev/null 
    return $?
}

if [ -x ~/.powerline-shell.py ] && test_powerline-shell; then

    function _update_ps1() {
	TMP="$(~/.powerline-shell.py --cwd-max-depth 3 $? 2> /dev/null)"
	if [ "$?" -ne "0" ]; then
	    TMP='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	fi
	export PS1=$TMP
    }

    export OLD_PROMPT_COMMAND="$PROMPT_COMMAND"
    export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"

else
    set_old_ps
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

PATH="$HOME/bin/:$PATH"

# Use find to ignore symlinks
sgrep ()
{

	local repo_ign="-name .git -o -name .svn"
	find . \( -type d -a \( $repo_ign \) \) -prune -o -type f -exec grep -H --color $@ {} \;
}


MAKE=/usr/bin/make
if [ -e /usr/bin/colormake ]; then
	# https://github.com/pagekite/Colormake
	MAKE=/usr/bin/colormake;
	complete -o filenames -F _make colormake
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
	local P="$HOME/projects/build/$(basename "$(pwd)")"
	local branch="_$(git branch)" || branch=''
	P=$P$branch
	mkdir -p "$P"
	echo "$P"
}

export EDITOR=vim

function isFedora()
{
	[ -e /etc/redhat-release ]
	return $?
}

function setMakeAliases()
{
	local prefix=$1
	local defconfig=$2

	alias makearm="make ARCH=arm CROSS_COMPILE=$prefix"
	export CCACHE_DIR="$HOME/local/.ccache_$prefix"
	export CCACHE_TEMPDIR="/dev/shm"
	#export PATH="/usr/lib/ccache:$PATH"

	alias makeu='makearm uImage'
	alias makez='makearm zImage'
	alias makedef="makearm $defconfig"
	alias makemod='makearm modules && makearm INSTALL_MOD_PATH=$PWD/ARM modules_install'
	alias makemenu="/usr/bin/make ARCH=arm CROSS_COMPILE=$prefix menuconfig"
	alias maked='makearm dtbs'
}

function buildenv()
{
	local tt=$1
	if [ ! -z "$TARGET_SYS" ]
	then
		echo "Target sys already set..."
		tt=""
	fi
	case "$tt" in
		l138|L138|oe2008)
			echo Setting up CL MityOMAP-L138 Build environment...
			. /usr/local/angstrom/arm/environment-setup

			setMakeAliases arm-angstrom-linux-gnueabi- industrialio_defconfig
			;;
		ipnc)
			echo Setting up IPNC Build environment...
			. /export/space/jcormier/TI_IPNC_RDK_DM36x_V5.1.0/Source/dvsdk_ipnctools/linux-devkit/environment-setup
			alias makearm="make ARCH=arm CROSS_COMPILE=arm-arago-linux-gnueabi-"
			export CCACHE_DIR="$HOME/local/.ccache_arm-arago-linux-gneuabi"
			export CCACHE_TEMPDIR="/dev/shm"
			export PATH="/usr/lib/ccache:$PATH"

			alias makemenu='/usr/bin/make ARCH=arm CROSS_COMPILE=arm-arago-linux-gnueabi- menuconfig'
			;;

		oe2012)
			echo Setting up CL MityOMAP-L138 OE 2012 Build environment...
			. /usr/local/oecore-i686/environment-setup-armv5te-angstrom-linux-gnueabi

			setMakeAliases arm-angstrom-linux-gnueabi- industrialio_defconfig
			#cd /usr/lib/ccache
			#sudo ln -s ../../bin/ccache arm-angstrom-linux-gnueabi-cpp
			#sudo ln -s ../../bin/ccache arm-angstrom-linux-gnueabi-g++
			#sudo ln -s ../../bin/ccache arm-angstrom-linux-gnueabi-gcc
			;;

		am335x|AM335X)
			isFedora && { echo "TI toolchain doesn't work in fedora"; return; }
			echo Setting up CL MityARM-AM335X Build environment...
			#. /usr/local/ti-sdk-am335x-evm/linux-devkit/environment-setup
			#. /usr/local/ti-sdk-am335x-evm-05.07.00.00/linux-devkit/environment-setup
			local toolchain=/usr/local/ti-sdk-am335x-evm-05.03.02.00/linux-devkit/environment-setup
			if [ ! -d $toolchain ] # if doesn't exist
			then
				toolchain=/net/mitydsp/export/space/ti-sdk-am335x-evm-05.03.02.00/linux-devkit/environment-setup
			fi
			. $toolchain

			setMakeAliases arm-arago-linux-gnueabi- mityarm-335x-devkit_defconfig
			;;
		am335x_new)
			isFedora && { echo "TI toolchain doesn't work in fedora"; return; }
			echo "Setting up (08.00.00.00) CL MityARM-AM335X Build environment..."
			local toolchain=/opt/ti-sdk-am335x-evm-08.00.00.00/linux-devkit/environment-setup
			if [ ! -d $toolchain ] # if doesn't exist
			then
				toolchain=/net/mitydsp/export/space/ti-sdk-am335x-evm-08.00.00.00/linux-devkit/environment-setup
			fi
			# Dont source toolchain for kernel
			#. $toolchain
			export PATH=/opt/ti-sdk-am335x-evm-08.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin:$PATH

			setMakeAliases arm-linux-gnueabihf- mityarm-335x-devkit_defconfig

			alias makedef2='makearm singlecore-omap2plus_defconfig'
			#cd /usr/lib/ccache
			#sudo ln -s ../../bin/ccache arm-linux-gnueabihf-cpp
			#sudo ln -s ../../bin/ccache arm-linux-gnueabihf-g++
			#sudo ln -s ../../bin/ccache arm-linux-gnueabihf-gcc
			;;
		timesys)
			echo Setting up MityARM-AM335X Timesys build environment
			local toolchain=$HOME/timesys/mityarm_335x/toolchain
			if [ ! -d "$toolchain" ] # if doesn't exist
			then
				toolchain=/net/mitydsp/export/space/timesys/mityarm335x/toolchain/
			fi
			export PATH=$toolchain/ccache:$toolchain/bin:$PATH

			setMakeAliases armv7l-timesys-linux-gnueabi- mityarm-335x-devkit_defconfig
			alias makeu2='makearm uImage modules LOADADDR=0x80008000'
			alias makedef2='makearm omap2plus_defconfig'
			;;
		timesys_distcc)
			echo Setting up MityARM-AM335X Timesys distcc build environment
			toolchain=/net/mitydsp/export/space/timesys/mityarm335x/toolchain/
			export PATH=$toolchain/ccache:$toolchain/bin:$PATH

			setMakeAliases "distcc $toolchain/bin/armv7l-timesys-linux-gnueabi-" mityarm-335x-devkit_defconfig
			alias makeu2='makearm uImage modules LOADADDR=0x80008000'
			alias makedef2='makearm omap2plus_defconfig'
			;;
		android)
			export PATH=~/bin/android-studio/bin:$PATH
			export JAVA_HOME=/etc/alternatives/java_sdk
			;;
		socfpga|5csx)
			/opt/altera/14.1/embedded/embedded_command_shell.sh
			alias eclipse="/usr/bin/eclipse"
			;;
		vanilla)
			echo Clearing make alias
			alias make='time make'
			MAKE=/usr/bin/make
			export QMAKESPEC=""
			;;
		*)
			echo "Toolchain TARGET_SYS = $TARGET_SYS"
			;;
	esac
}

isMounted()
{
	local mountPT=$1
	mountpoint -q "$mountPT"
	return $?
}

waitForMount()
{
	local mountPT=$1
	while ! isMounted "$mountPT"; do
		sleep .5
	done
}

if [ -d /media/jcormier ]
then
	mountDir=/media/jcormier
else
	mountDir=/media
fi

waitForSD()
{
	echo Insert SD Card;
	waitForMount "$mountDir/boot" &&
		waitForMount "$mountDir/rootfs" &&
		waitForMount "$mountDir/START_HERE"
	sleep .5
}

umountSD()
{ 
	# Try unmounting 3 times before erroring out
	waitTime=1
	umount "$mountDir"/* ||
		(sleep $waitTime; umount $mountDir/*) ||
		(sleep $waitTime; umount $mountDir/*) ||
		return 1
	return 0
}

copyUImage()
{
	waitForSD &&
		cp -v arch/arm/boot/uImage "$mountDir/boot/" &&
		umountSD;
	mount | grep media
}

copyMLO()
{
	waitForSD && 
		cp -v MLO u-boot.img "$mountDir/boot/" && 
		umountSD; 
	mount | grep media
}

alias cpuimage='copyUImage'
alias cpmlo='copyMLO'

#Save history immediately
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

#CCACHE
export CCACHE_DIR="$HOME/local/.ccache"
export CCACHE_TEMPDIR="/dev/shm"
export PATH="/usr/lib/ccache:$PATH"

#QMAKESPEC=/usr/local/ti-sdk-am335x-evm-05.07.00.00/linux-devkit/arm-arago-linux-gnueabi/usr/share/qtopia/mkspecs/linux-g++;export QMAKESPEC; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - AB1C36D0-2B62-930A-B1CF-1B15CF69BE47 F5B7D4D6-21B6-393F-0929-39B2C5CE5B56

#QMAKESPEC=/usr/local/ti-sdk-am335x-evm-06.00.00.00/linux-devkit/arm-arago-linux-gnueabi/usr/share/qtopia/mkspecs/linux-g++;export QMAKESPEC; # ADDED BY INSTALLER - DO NOT EDIT OR DELETE THIS COMMENT - AB1C36D0-2B62-930A-B1CF-1B15CF69BE47 799A5755-0755-FE0C-9F76-A336F294C7FA

#source ~/.completion

# Causes missing command to prompt to be installed
export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#MINICOM Enable color mode and use of Meta <Alt> keys and enable wrapping
export MINICOM='-m -c on -w'
