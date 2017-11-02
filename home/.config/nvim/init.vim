filetype off
" Leaders. {{{
let mapleader = ","
let g:mapleader = ","
" }}}
" Plug install {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://github.com/junegunn/vim-plug/raw/master/plug.vim
  function! AuPlugged()
    exe ':PlugInstall'
    echom 'Installing plugins... **Restart Vim to load them!**'
  endfunction
  augroup AuPlugged
    autocmd!
    autocmd VimEnter * call AuPlugged()
  augroup END
endif
" }}}
" Plugs {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/vim-cursorword' " underline word under cursor
" Plug gist {{{
Plug 'mattn/webapi-vim' " gist webapi
Plug 'mattn/gist-vim' " gist
let g:gist_post_private = 1
" }}}
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' } " go compl
" Plug vim-go {{{
" Plug 'fatih/vim-go' " go support
fun! GoRunWrapper()
  execute "GoRun"
  exe "normal! \<esc>"
endfunction
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>i :GoImport 

let g:go_snippet_engine = "neosnippet"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_term_mode = "split"
let g:go_term_enabled = 1
" }}}
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'sheerun/vim-polyglot' " language based plugins
" Plug 'digitaltoad/vim-pug' " pug or jade templating language
Plug 'duggiefresh/vim-easydir' " allow creating directories with edit
Plug 'airblade/vim-gitgutter' " show git gutter tags
" Plug 'tpope/vim-markdown' " markdown support
Plug 'editorconfig/editorconfig-vim' " editorconfig support
Plug 'christoomey/vim-tmux-navigator' " simplify navigating between tmux and vim
Plug 'cohama/lexima.vim' " auto close parentheses
Plug 'moll/vim-node' " better node support for vim
Plug 'kshenoy/vim-signature' " show marks on left pane
Plug 'tpope/vim-commentary' " gcc to comment out lines
Plug 'tpope/vim-eunuch' " linux helpers for vim :Rename etc
Plug 'tpope/vim-surround' " cs ds for surrounding tags
Plug 'tpope/vim-unimpaired' " basic toggling options
Plug 'tpope/vim-vinegar' " make netrw great again
Plug 'thinca/vim-visualstar' " better visual selection through *
Plug 'mustache/vim-mustache-handlebars' " mustache handlebars template helpers
Plug 'tpope/vim-repeat' " make repeat great again. Helps repeat all tpope libs
" Plug autoformat {{{
Plug 'Chiel92/vim-autoformat'
noremap <F3> :Autoformat<CR>
" }}}
" Plug completion manager {{{
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/nvim-cm-tern', {'do': 'npm install -g tern && npm install'}
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}
" Plug tagbar {{{
Plug 'majutsushi/tagbar'
nmap <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" Tweaks apparance.
let g:tagbar_width = 60
let g:tagbar_compact = 1
let g:tagbar_indent = 4
let g:tagbar_iconchars = [' ', ' ']
nnoremap <leader><F4> :TagbarToggle<CR>/
" }}}
" Plug tig {{{
Plug 'codeindulgence/vim-tig'
nmap tig :Tig!<CR>
" }}}
" Plug fzf {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Search from directory using AG {{{
function! FZFSearchInDir(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir FZFAgIn call FZFSearchInDir(<f-args>)
" }}}

" Project root files {{{
function! FZFFindGitRoot()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! FZFProjectFiles execute 'Files' FZFFindGitRoot()
" }}}

imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)

nmap K :Ag <C-R><C-W><CR>
nnoremap /f :FZFAgIn %:p:h<CR>
nnoremap /d :FZFProjectFiles<CR>
nnoremap /a :Files %:p:h<CR>
nnoremap /s :Files<CR>
nnoremap /x :Tags<CR>
nnoremap /b :Buffers<CR>
nnoremap /m :History<CR>
nmap <Leader>gs :GFiles?<CR>

" FASD integration {{{

function! s:fasd_update() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    call jobstart(['fasd', '-A', expand('%:p')])
  endif
endfunction
augroup fasd
  autocmd!
  autocmd BufWinEnter,BufFilePost * call s:fasd_update()
augroup END
command! FASD call fzf#run(fzf#wrap({'source': 'fasd -al', 'options': '--no-sort --tac --tiebreak=index'}))
nnoremap <silent> /z :FASD<CR>
" }}}
" }}}
" Plug: ale {{{
Plug 'w0rp/ale'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {
  \ 'go': ['gometalinter', 'gofmt'],
  \ 'javascript': ['eslint']
  \}
let g:ale_fixers = {
  \ 'javascript': ['eslint'],
  \ }
nmap <leader>d <Plug>(ale_fix)
" }}}
" {{{ Plugin projectroot
Plug 'dbakker/vim-projectroot'

" Navigate to root `root_dir` directory
nnoremap \rd :execute ':cd ' . projectroot#guess() <CR>:pwd<CR>
set browsedir=current
" }}}
" Plug: easymotion {{{
Plug 'Lokaltog/vim-easymotion'
map <Space> <Plug>(easymotion-s)
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map /j <Plug>(easymotion-j)
map /k <Plug>(easymotion-k)
" }}}
" Plug: javaScript {{{
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1
" }}}
" gutentags {{{
Plug 'ludovicchabant/vim-gutentags'
set tags=./tags;,tags;
let g:gutentags_ctags_exclude = ['*.min', 'node_modules']
" let g:gutentags_ctags_executable_javascript = '~/.config/nvim/scripts/jsctags.sh'
" let g:gutentags_trace=1
" }}}
" Plug: ultisnips {{{
Plug 'SirVer/ultisnips' |  Plug 'kirstein/vim-snippets'
" c-o triggers a snippet
let g:UltiSnipsExpandTrigger="<c-o>"

" load snippets from dir
let snipsDir = $HOME."/workspace/kirstein/vim-snippets/"
let g:UltiSnipsSnippetDirectories=[ 'UltiSnips' ]
if isdirectory(snipsDir)
  let g:UltiSnipsSnippetDirectories=[ snipsDir."/UltiSnips" ]
else
endif
" }}}
" Plug: fugitive {{{
Plug 'tpope/vim-fugitive'
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gc :Gcommit -m
nmap <Leader>gp :Gpush
" }}}
call plug#end()
" }}}

filetype plugin indent on

" Statusline {{{
"statusline setup
set statusline =%#identifier#
set statusline+=\ \%t\ \   "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

set statusline+=%#error#
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%m%=%f[%02p%%,04l,%03v]%{fugitive#statusline()}
set laststatus=2
" }}}
" Directory assigning {{{
" Make PWD the current file
nnoremap \cd :cd %:p:h<CR>:pwd<CR>
" }}}
" Clipboard  {{{
set clipboard=unnamed
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP
" }}}
" Folding {{{
set modelines=1
set nofoldenable
set foldmethod=indent
" set foldmarker={,}
set foldlevelstart=100
set foldnestmax=4
nnoremap <Leader>z zMzAzz
" }}}
" General {{{
nnoremap <silent> <Leader>cc :vimgrep /<C-r><C-w>/ %<CR>``:cw<CR>
map <silent> nl :lnext<CR>
map <silent> nl :lnext<CR>
" Give access to mouse support
" Usable for resizing panes
set mouse+=a

" . is not a word!
set iskeyword-=.

" I constantly have a problem with leader s fast saving
" since i dont use s for replace lets remove it
map s <Nop>

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" God damn, i hate when new splits are added to left and top
set splitbelow
set splitright

" Consistant Y
map Y y$

map <Leader>ts :tab split<CR>
map <Leader>tc :tabc<CR>

nmap <Leader>q :q<CR>
nmap /q q:

map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Switch quickly between buffers
nmap // <c-^>

" Rotate through buffers
nmap <C-n> :bn<CR>
nmap <C-p> :bp<CR>

nmap <silent> <leader>c :bp\|bd #<CR>

" Select what has been pasted
noremap gV `[v`]

" Better bracket jumping
noremap % v%

" Keep the visual block if indenting
vnoremap > >gv
vnoremap < <gv

" Allow unsaved buffers
set hidden

" map @q to Q, quicker macros
" Used recursive mapping because of vim bekaboo
nmap Q @q

" Toggle f2 as paste mode
set pastetoggle=<F2>

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>s :w!<cr>

" Fuzzy search with find
set path+=**

" Open locationlist
nnoremap <silent> <Leader>l :lopen<CR>

map nvim :e ~/.config/nvim/init.vim<CR>
" }}}
" Window / pane movements {{{
if has('nvim')
  nmap <bs> <C-w>h
else
  map <C-h> <C-w>h
endif
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" }}}
" VIM user interface {{{
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
set wildmode=longest:full,full

" " Ignore compiled files
set wildignore=.git,*/tmp,**/node_modules/**,*/node_modules

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Various characters are wider than normal fixed width characters, but the
" default setting of ambiwidth (single) squeezes them into normal width, which
" sucks.  Setting it to double makes it awesome.
set ambiwidth=double

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set cursorline
" set termguicolors
colorscheme onehalfdark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile
" }}}
" Text, tab and indent related {{{
" Use paces instead of tabs
set expandtab

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch
set inccommand=split

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Use one space instead of two when joining lines
set nojoinspaces

" Automatic save on buffer change etc
set autowriteall

" Use relative numbers
" set relativenumber
" set number
" }}}
" List chars {{{
set showbreak=↪

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:.

" Colors for chars
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" }}}
" Global undo list {{{
let vimDir = '$HOME/.config/nvim'
set undolevels=1000
set undoreload=10000

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " Create dirs
  call system('mkdir -p' . vimDir)
  call system('mkdir -p' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif
" }}}
" Autocommands {{{
" Display too long lines {{{
autocmd FileType ruby,python,javascript,coffee,vim autocmd BufWritePre <buffer> match ErrorMsg '\%>100v.\+'
" }}}
" Remove trailing whitespaces when dealing with certain languages  {{{
autocmd FileType ruby,python,javascript,coffee,markdown autocmd BufWritePre <buffer> :%s/ \+$//ge
" " }}}
" Show trailing whitespaces {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }}}
" }}}
" Custom functions {{{
" Duplicate line under cursor {{{
nmap <silent> <Leader>dd :call DupLine()<CR>

function! ToggleNumbers()
  set relativenumber!
  set number!
endfunction

nmap <silent> con :call ToggleNumbers()<CR>

" Duplicate the current line and keep the cursor as it was
function! DupLine()
  let a:cursor_pos = getpos(".")
  :t.
  call cursor(getpos('.')[1], a:cursor_pos[2])
endfunction
" }}}
" Open the first matching variable with require statement {{{
nmap <silent> gw :call OpenFirstRequire()<CR>
function! OpenFirstRequire()
  let l:name = expand("<cword>")
  " Find require statement
  " Matches the following cases. Work both for js and coffeescript
  "  1. = require or =require
  "  2. ('location') or 'location' or ("location") or "location"
  let l:regexp = l:name . '\s*=\s*require\s*\((\|\s\)\(''\|"\).*\(''\|"\)\()\|\s*\)'
  let l:lnr = 0
  let l:loc = 0
  while l:lnr < line('$')
    let l:line = getline(l:lnr)
    if len(matchstr(l:line, l:regexp))
      for i in split(l:line, '\zs')
        if l:loc != 0 && len(matchstr(i, '\(''\|"\)'))
          call cursor(l:lnr, l:loc)
          normal! gF"
          return
        endif
        let l:loc = l:loc + 1
      endfor
      break
    endif
    let l:lnr = l:lnr + 1
  endwhile
endfunction
" }}}
" Wrap stuff to console.time {{{
fun! ConsoleTime() range
  let name = input("Name: ")
  "let name = 'test'
  if len(name) > 0
    let start = "console.time('".name."');"
    let end   = "console.timeEnd('".name."');"
    normal! `>j
    exe "normal! O".end."\<CR>"
    normal! `<k
    exe "normal! o\<CR>".start
    normal! `<
  endif
endfunction
" }}}
" Turn normal fn to coroutine {{{
fun! Co() range
  normal! 0dwiconst 
  normal! f(i = Promise.coroutine(function * 
  normal! f{%a);
  normal! ``
endfunction
" }}}
" }}}
" I suck at spelling {{{

iab reuqure require
iab reuire require
iab teh the
iab testilo testlio
iab quesiton question
iab worksapce workspace
iab stirngify stringify
" }}}

" vim:foldmethod=marker:foldlevel=0
