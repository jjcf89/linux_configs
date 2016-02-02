alias umountall='sudo umount /media/jcormier/*'

#### Search shortcuts
alias rgrep='grep -RI --exclude-dir=.svn --exclude-dir=*.prj_files'       # Recursive grep ignoring svn files
alias cgrep='rgrep --include=*.{c,cpp,h,py}'
alias tgrep='dmesg | grep ttyUSB'
#SACK SAG
alias sag='sack -ag'

# Discover file hogs in current directory
alias ducks='du -cks * |sort -rn |head -11'

#### VIM shortcuts
# Open files in already open gvim
alias g='gvim --remote-silent'

alias markcscopedb='export CSCOPE_DB=`pwd`'

#### Git shortcuts
alias gits='git status'
alias gcp='git cherry-pick -xs'
# Open gitk limiting history to 2k entries
function gitk_launch() {
    gitk -n2000 $@ &
}
alias gitk='gitk_launch'

#### SVN shortcuts
alias svndiff='svn diff | less'

#### Misc
alias cdwork="cd /data/work"

alias sync="time sync"
alias umount="time umount"

# Should allow sudo to run aliases
alias sudo='sudo '

function screen_serial()
{
	TTY=$1
	screen /dev/ttySerial$TTY 115200 
}
alias serial='screen_serial'
