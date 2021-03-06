"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle Install
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"" a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'
"" This is a simple plugin that helps to end certain structures automatically
Plugin 'tpope/vim-endwise'
"" Syntastic is a syntax checking plugin for Vim
Plugin 'scrooloose/syntastic'
"" Lean & mean status/tabline for vim that's light as air.
Plugin 'vim-airline/vim-airline'
"" A code-completion engine for Vim
Plugin 'Valloric/YouCompleteMe'
"" Provides easy code formatting in Vim by integrating existing code formatters.
Plugin 'Chiel92/vim-autoformat'
"" A dark colourscheme for Vim created for fun
Plugin 'Pychimp/vim-luna'
"" A fancy start screen for Vim.
Plugin 'mhinz/vim-startify'
"" Vastly improved Javascript indentation and syntax support in Vim.
Plugin 'pangloss/vim-javascript'
"" Vim plugin to respect the Linux kernel coding style
Plugin 'vim-scripts/linuxsty.vim'
"" frontend for ag
Plugin 'rking/ag.vim'
"" Tagbar is a Vim plugin that provides an easy way to browse the tags of the current file
Plugin 'majutsushi/tagbar'
"" Insert or delete brackets, parens, quotes in pair
Plugin 'jiangmiao/auto-pairs'
"" Edit Files using sudo or su or any other tool
Plugin 'chrisbra/SudoEdit.vim'
"" This plugin causes all trailing whitespace characters (spaces and tabs) to be highlighted
Plugin 'ntpeters/vim-better-whitespace'
"" Improve vim sessions. Start session recording with :Obsess
Plugin 'tpope/vim-obsession'
"" A Vim plugin which shows a git diff in the 'gutter' (sign column).
Plugin 'airblade/vim-gitgutter'
"" A Filetype plugin for csv files
Plugin 'chrisbra/csv.vim'
"" Enable repeating supported plugin maps with "."
Plugin 'tpope/vim-repeat.git'
""  Simplified clipboard functionality for Vim
Plugin 'svermeulen/vim-easyclip'
""  Vim Space Controller
Plugin 'vim-ctrlspace/vim-ctrlspace'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YCM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"where to search for .ycm_extra_conf.py if not found
let g:ycm_global_ycm_extra_conf = '~/.configs/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Enable reading settings from file comments
set modeline

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu
set wildmode=list:longest,full

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

set background=dark
set nonu "Disable line numbers

set encoding=utf8
set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
if has('persistent_undo')
    set undodir=~/.vim_runtime/undodir
    set undofile
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use tabs
let my_tab=4
set tabstop=4
set smarttab

" Values toggled
set noexpandtab
execute "set shiftwidth=".my_tab
execute "set softtabstop=0"

" allow toggling between local and default mode
function! TabToggle()
    if &expandtab
        execute "set shiftwidth=".g:my_tab
        execute "set softtabstop=0"
        set noexpandtab
    else
        execute "set shiftwidth=".g:my_tab
        execute "set softtabstop=".g:my_tab
        set expandtab
    endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z

set lbr
set tw=500

set noai "Auto indent
set nosi "Smart indet
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

" https://dev.launchpad.net/UltimateVimPythonSetup
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
endif

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated .git'
set grepprg=/bin/grep\ -nH

" Use silver surfer for grep command
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nnoremap \ :grep<SPACE>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CSCOPE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LoadCscope()
    if (executable("cscope") && has("cscope"))
        let UpperPath = findfile("cscope.out", ".;")
        if (!empty(UpperPath))
            let path = strpart(UpperPath, 0, match(UpperPath, "cscope.out$") - 1)   
            if (!empty(path))
                let CscopeAddString = "cs add " . UpperPath . " " . path 
                execute CscopeAddString 
            endif
        endif
    endif
endfunction
command! LoadCscope call LoadCscope()
set cscoperelative

"""
" => Airline
"""
let g:airline#extensions#tabline#enabled = 1

"""
" => vim-gitgutter
"""
set updatetime=250 " Update every 250ms
" You can jump between hunks with [c and ]c. You can preview, stage, and undo hunks with <leader>hp, <leader>hs, and <leader>hu respectively.

"""
" => EasyClip
"""
" Result of default EasyClip, remap else to 'add mark'. To use gm for 'add mark' instead of m.
nnoremap gm m

" Don't override vim defaults 'm' and 's'
let g:EasyClipUseCutDefaults = 0
nmap yd <Plug>MoveMotionPlug
xmap yd <Plug>MoveMotionXPlug
nmap ydd <Plug>MoveMotionLinePlug

"""
"My settings
"""
"Change working directory to directory of file
set autochdir

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

let g:pymode_run_key = 'R'

nnoremap <c-b> :make<cr>

" Set color to 256 colors
if !has('gui_running')
    set t_Co=256
endif

silent! colorscheme luna

function! RemoveKernelTiming()
    execute "%s/\\[\\s*\\d*\\.\\d*\\s*\\]/[]/g"
endfunction
command! RemoveKernelTiming call RemoveKernelTiming()

"Create mapping that runs current file as command
map <leader>r :!./%

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"" Taken from https://github.com/ehartc/dot-vimrc

" Can move cursor past end of line, where there are no characters, in visualblock mode
set virtualedit=block

" Start diff mode with vertical splits.
set diffopt=vertical

" 1 space, not 2, when joining sentences.
set nojoinspaces

" Delete comment character when joining commented lines, so two lines of comment becomes one line when joining, without comment mark.
if v:version + has("patch541") >= 704
   set formatoptions+=j
endif

"" Without need to press shift, go into command modus. For the original use of ;, see plugin Clever-f.
nore ; :

" Press same key ; again, to enter the command. If you really need to type ; in the command line (be frankly, it will never happen), C-v then ;
autocmd CmdwinEnter * nnoremap <buffer> ; <CR><BS>

" Use CTRL-p for paste from system clipboard (works on Linux distro's and Windows)
noremap <C-p> :set paste<CR>"*p:set nopaste<CR>

" Go to normal mode when rolling the fingers. I prefer it above 'jj' and it's even faster.
inoremap jk <Esc>
inoremap kj <Esc>

" Q to replay the marco.
nnoremap Q @q

"Ever make similar changes to two files and switch back and forth between them? (Say, source and header files?)
nnoremap <TAB> :e#<CR>
