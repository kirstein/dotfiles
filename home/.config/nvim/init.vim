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
call plug#begin('~/.local/share/nvim/plugged')
" Bundles {{{
Plug 'flazz/vim-colorschemes'
Plug 'digitaltoad/vim-pug'
Plug 'Konfekt/FastFold'
Plug 'metakirby5/codi.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'kylef/apiblueprint.vim'
Plug 'avakhov/vim-yaml'
Plug 'duggiefresh/vim-easydir'
Plug 'kirstein/vim-execute-ft'
" Bundle neotags {{{
" Bundle tagbar {{{
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
Plug 'tpope/vim-projectionist'
Plug 'dbakker/vim-projectroot'
Plug 'tpope/vim-haml'
Plug 'rizzatti/dash.vim'
Plug 'airblade/vim-gitgutter'
" Bundle deoplete {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
" Plug ternjs{{{
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern && npm install -g jsctags' }
" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
let g:tern#arguments = ["--persistent"]
autocmd CompleteDone * pclose
" Use deoplete.
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
" }}}
" }}}
Plug 'tpope/vim-markdown'
Plug 'itspriddle/vim-marked'
Plug 'editorconfig/editorconfig-vim'
Plug 'rking/ag.vim'
" Bundle: CtrlP {{{
Plug 'ctrlpvim/ctrlp.vim'
nnoremap /d :CtrlPCurWD<CR>
nnoremap /b :CtrlPBuffer<CR>
nnoremap /m :CtrlPMRU<CR>
nnoremap /x :CtrlPTag<CR>
nnoremap /a :CtrlPCurFile<CR>
nnoremap /g :CtrlPLine<CR>

" Add fugitive porn to ignore
let g:ctrlp_custom_ignore = '\.fugitive.*'

" Overwrite the default mapping in order to let the C+p work
let g:ctrlp_map = "/t"
let g:ctrlp_extensions = [ 'line' ]

let g:ctrlp_working_path_mode = 'ra'
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_custom_ignore = 'jmeter\|coverage\|target\|node_modules\|.DS_Store\|.git\'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
" }}}
Plug 'mattn/emmet-vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'jpalardy/vim-slime'
Plug 'christoomey/vim-tmux-navigator'
" Bundle: Ale {{{
Plug 'w0rp/ale'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
" }}}
Plug 'kana/vim-textobj-user'
Plug 'coderifous/textobj-word-column.vim'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-smartinput'
" Bundle: Easymotion {{{
Plug 'Lokaltog/vim-easymotion'
map <Space> <Plug>(easymotion-s)
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map /j <Plug>(easymotion-j)
map /k <Plug>(easymotion-k)
" }}}
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
" Gutentags {{{
Plug 'ludovicchabant/vim-gutentags'
set tags=./tags;,tags;
let g:gutentags_exclude = ['*.min', 'node_modules']
" let g:gutentags_ctags_executable_javascript = '~/.config/nvim/scripts/jsctags.sh'
" let g:gutentags_trace=1
" }}}
"Plug 'edsono/vim-matchit'
" Bundle: Ultisnips {{{
Plug 'SirVer/ultisnips' |  Plug 'kirstein/vim-snippets'
" c-o triggers a snippet
let g:UltiSnipsExpandTrigger="<c-o>"

" load snippets from dir
let snipsDir = $HOME."/workspace/github/kirstein/vim-snippets/"
let g:UltiSnipsSnippetDirectories=[ 'UltiSnips' ]
if isdirectory(snipsDir)
  let g:UltiSnipsSnippetDirectories=[ snipsDir."/UltiSnips" ]
else
endif
" }}}
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'thinca/vim-visualstar'
Plug 'mustache/vim-mustache-handlebars'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'mxw/vim-jsx'
" }}}
call plug#end()
" }}}

filetype plugin indent on

" Testing helpers {{{
let g:execute_ft_commands = { 
      \'javascript': { 'all': 'Dispatch npm test', 'single': 'Dispatch npm test -- {file}' },
      \'ruby': { 'all': 'Rake spec test', 'single': 'Rake spec SPEC={file}' },
      \'php': { 'all': 'Dispatch composer run test', 'single': 'Dispatch composer run test -- {file}' }
      \}

map <silent> \\ :call ExecuteByFtLast()<CR>
map <silent> \a :call ExecuteByFT("all")<CR>
map <silent> \t :call ExecuteByFT("single")<CR>
map <silent> <C-c>j :wincmd j<CR>:bd<CR>
" }}}
" " Bundle: table {{{
" let g:table_mode_corner="|"
" " }}}
" " Bundle: Rails + rspec {{{
" map <silent><leader>. :A<CR>
" map <silent><leader>\ :AV<CR>
" map <silent><leader>rr :Rake routes<CR>
" map <silent><leader>re :Rextract 

" map <leader>em :Emodel 
" map <leader>ec :Econtroller 
" map <leader>ev :Eview 
" map <leader>es :Estylesheet 
" map <leader>el :Elayout 
" map <leader>vm :Vmodel 
" map <leader>vc :Vcontroller 
" map <leader>vv :Vview 
" map <leader>vs :Vstylesheet 
" map <leader>vl :Vlayout 
" " }}}
" " Bundle: Syntastic {{{
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_javascript_checkers=[ 'eslint' ]
" }}}
" Bundle: Notes {{{
let g:notes_directories = ['~/Dropbox/notes']
" }}}
" " Bundle: Neocomplete {{{
" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" let g:acp_enableAtStartup = 0
" let g:neocomplete#max_list = 10
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#force_overwrite_completefunc = 1

" " Tab complete
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " }}}
" " Bundle: Slime {{{
" let g:slime_target = "tmux"
" let g:slime_paste_file = tempname()
" " }}}
" Bundle: JavaScript {{{
let g:javascript_plugin_jsdoc = 1
" }}}
" Bundle: Fugitive {{{
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gc :Gcommit -m 
nmap <Leader>gp :Gpush
" }}}
" Bundle: Ag {{{
" bind K to grep word under cursor
nmap K :Ag! "<C-R><C-W>"<CR>
vmap K y:<C-U>Ag! '<C-R>"'<CR>

" Find all todo tags
map todo :Ag! -i "todo"<CR>
map <leader>f :Ag! 
map <leader>F :Ag! -i 

nmap <silent> <C-f> :CtrlSF 
let g:ctrlsf_winsize = '50%'
" }}}
" Bundle: Gist {{{
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_post_private = 1
let g:gist_show_privates = 1
" }}}

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

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{fugitive#statusline()}
set laststatus=2

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let b:statusline_tab_warning = ''

    if !&modifiable
      return b:statusline_tab_warning
    endif

    let tabs = search('^\t', 'nw') != 0

    "find spaces that arent used as alignment in the first indent column
    let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning =  '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    endif
  endif
  return b:statusline_tab_warning
endfunction
" }}}
" Directory assigning {{{
" Make PWD the current file
nnoremap \cd :cd %:p:h<CR>:pwd<CR>

" Navigate to root `root_dir` directory
nnoremap \rd :execute ':cd ' . projectroot#guess() <CR>:pwd<CR>

" let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
" let g:netrw_liststyle    = 3
" let g:netrw_sort_options = 'i'
" let g:netrw_altv         = 1
" let g:netrw_browse_split = 4

set browsedir=current
nnoremap <silent> <C-e> :Lex %:p:h<CR>
" }}}
" Clipboard  {{{
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP
" }}}
" Tags {{{
" let g:easytags_auto_update = 1

" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" }}}
" Folding {{{
set modelines=1
" set nofoldenable
set foldmethod=indent
" set foldmarker={,}
set foldlevelstart=1
set foldnestmax=4
nnoremap <Leader>z zMzAzz
" }}}
" Bash helpers {{{
nmap tig :!tig %<CR>

" Format json
nmap =j :%!python -m json.tool<CR>
" }}}
" General {{{
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

" Display the last search in quickfix window
nnoremap <silent> <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

map nvim :e ~/.config/nvim/init.vim<CR>
" }}}
" Window / pane movements {{{
" Easy window navigation {{{
if has('nvim')
  nmap <bs> <C-w>h
else
  map <C-h> <C-w>h
endif
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" }}}
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

" Line numbers
set number

set cursorline

colorscheme monokai

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
set relativenumber
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

" Autocommands {{{
" Display too long lines {{{
autocmd FileType ruby,python,javascript,coffee,vim autocmd BufWritePre <buffer> match ErrorMsg '\%>100v.\+'
" }}}
" Remove trailing whitespaces when dealing with certain languages  {{{
autocmd FileType ruby,python,javascript,coffee,markdown autocmd BufWritePre <buffer> :%s/ \+$//ge
" " }}}
" Reload vimrc config each time its saved {{{
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,~/.config/nvim/init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" }}}
" Replace highlight line when insert and vice versa {{{
autocmd InsertEnter,InsertLeave * set cul!
" }}}
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
" Zoom in given pane {{{
func! s:zoom_toggle() abort
  if 1 == winnr('$')
    return
  endif
  let restore_cmd = winrestcmd()
  wincmd |
  wincmd _
  " If the layout did not change, it's a toggle (un-zoom).
  if restore_cmd ==# winrestcmd()
    exe t:zoom_restore
  else
    let t:zoom_restore = restore_cmd
  endif
  return '<Nop>'
endfunc
func! s:zoom_or_goto_column(cnt) abort
  if a:cnt
    exe 'norm! '.v:count.'|'
  else
    call s:zoom_toggle()
  endif
endfunc
nnoremap + :<C-U>call <SID>zoom_or_goto_column(v:count)<CR>
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
" Duplicate line under cursor {{{
nmap <silent> <Leader>dd :call DupLine()<CR>

" Duplicate the current line and keep the cursor as it was
function! DupLine()
  let a:cursor_pos = getpos(".")
  :t.
  call cursor(getpos('.')[1], a:cursor_pos[2])
endfunction
" }}}
" Turn implicit return into a function {{{
function! FuckImplicitReturn()
  normal! $T>
  normal! vf)
  normal! "pd
  execute "normal! i {\<CR>\<CR>}"
  normal! kireturn
  normal! "pp$i;
  normal! ==
endfunction
" }}}
" Turn a function into a implicit return {{{
function! HelloImplicitReturn()
  normal! ^dwvt;"p
  execute "normal! \<esc>"
  normal! di}
  execute "normal! k\<S-j>hdf}"
  normal! 2h"pplx
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
" }}}
" I suck at spelling {{{

iab reuqure require
iab reuire require
iab teh the
iab testilo testlio
iab quesiton question
iab worksapce workspace
" }}}

" vim:foldmethod=marker:foldlevel=0
