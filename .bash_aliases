alias umountall='sudo umount /media/jcormier/*'

#### Search shortcuts
alias rgrep='grep -RI --exclude-dir=.svn --exclude-dir=*.prj_files'       # Recursive grep ignoring svn files
alias cgrep='rgrep --include=*.{c,cpp,h,py}'
#SACK SAG
alias sag='sack -ag'

#### VIM shortcuts
# Open files in already open gvim
alias g='gvim --remote-silent'

alias markcscopedb='export CSCOPE_DB=`pwd`'

#### Git shortcuts
alias gits='git status'
alias gcp='git cherry-pick -xs'
# Open gitk limiting history to 2k entries
alias gitk='gitk -n2000'

#### SVN shortcuts
alias svndiff='svn diff | less'

#### Misc
alias cdwork="cd /data/work"

# Should allow sudo to run aliases
alias sudo='sudo '
