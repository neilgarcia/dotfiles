call plug#begin('~/.vim/plugged')
scriptencoding utf-8

" Theme
" Get object name for syntax highlighting
" echom synIDattr(synID(line('.'),col('.'),0),'name')
Plug 'joshdick/onedark.vim'

" Auto completion
if has('nvim')
  Plug 'roxma/nvim-completion-manager', {'do': 'npm install'}
  Plug 'roxma/ncm-rct-complete'
  Plug 'roxma/nvim-cm-tern', {'do': 'npm install'}
  " Neovim completion manager
  let g:endwise_no_mappings = 1
  imap <C-X><CR>   <CR><Plug>AlwaysEnd
  imap <expr> <CR> (pumvisible() ? "\<C-Y>\<CR>\<Plug>DiscretionaryEnd" : "\<CR>\<Plug>DiscretionaryEnd")
endif

" Autocomplete
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neilgarcia/vim-react-snippets'
Plug 'othree/csscomplete.vim'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-qf'

" Tests
Plug 'janko-m/vim-test'
Plug 'kassio/neoterm'

" File explorer
Plug 'scrooloose/nerdtree'

" Tag generation
Plug 'ludovicchabant/vim-gutentags'

" Linting
Plug 'w0rp/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

"Language specific
Plug 'vim-ruby/vim-ruby'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Text object
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'wellle/targets.vim'

" Extras
Plug 'tpope/vim-repeat'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-endwise'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-sayonara'
Plug 'junegunn/vim-easy-align'
Plug 'Konfekt/FastFold'
Plug 'AndrewRadev/linediff.vim'
Plug 'ckarnell/history-traverse'
Plug 'terryma/vim-multiple-cursors'


call plug#end()

" OS Specific commands
let g:os = substitute(system('uname'), '\n', '', '')

" Set python path
if g:os == "Darwin"
  let g:python_host_prog  = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3'
  nnoremap <leader>cfp :!echo "%" \| pbcopy<CR><CR>
  nnoremap <leader>cfP :!echo "%:p" \| pbcopy<CR><CR>
elseif g:os == "Linux"
  let g:python_host_prog  = '/usr/bin/python'
  let g:python3_host_prog = '/usr/bin/python3'
  nnoremap <leader>cfp :let @+ = expand("%")<CR>
  nnoremap <leader>cfP :let @+ = expand("%:p")<CR>
endif

let g:mapleader      = ' '
let g:maplocalleader = ' '
noremap , <Space>

syntax on
filetype plugin indent on

" Edit and source vimrc
map <leader>vr :tabedit $MYVIMRC<CR>
map <leader>so :source $MYVIMRC<CR>


" Basic Configs
set hidden
set number            " Show line number
set relativenumber
set ruler
set cursorline
set cursorcolumn
set autoread
set timeoutlen=500    " Dont wait too long for the next key press (useful for ambigous leader commands)

""
"" Undo history
""

if has('persistent_undo')
set undodir=~/.undodir/
set undofile
endif

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
" off and the line continues beyond the left of the screen


""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter


""
"" Backup and swp files
""

set backupdir=~/.tmp " Where to put backup files
set directory=~/.tmp " Where to put swap files

""
"" Tags
""

set tags=./tags,tags;/


""
"" Au Group
""
augroup autocommands
  autocmd!
  " autocmd BufEnter * EnableStripWhitespaceOnSave " strip whitespace on save
  autocmd! FileType fzf tnoremap <buffer> <Esc> <c-c>
  autocmd FileType gitcommit noremap <buffer> d :call GStatusTabDiff()<CR>
  autocmd BufWinEnter * if empty(expand('<afile>'))|call fugitive#detect(getcwd())|endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " autocmd BufNewFile,BufRead *.jsx set filetype=javascript
  autocmd BufNewFile,BufRead *.js  set filetype=javascript.jsx
  autocmd FocusGained,BufEnter * :silent! !
  autocmd FileType qf noremap <Esc> :cclose<CR>
augroup END

""
"" User defined commands
""

" bind : to ;
nnoremap ; :

" Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

if (exists('+colorcolumn'))
set colorcolumn=80
highlight ColorColumn ctermbg=1
endif

" Close tab
ca qt tabclose

" Show all tags instead of jumping into 1 like a fucking idiot
"nnoremap <C-]> g<C-]>

" Redo
map U :redo<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Formats entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" Split management
set splitbelow 								"Make splits default to below...
set splitright								"And to the right. This feels more natural.

" Easier split navigations
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" Maps save to Ctrl S
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Copy file path easily for unit testing
set clipboard=unnamedplus

" Remove highlight
map <leader>nh :nohlsearch<CR>

" Ctrl backspace deletes word
inoremap <C-BS> <C-w>

""
"" Theme
""

if (has('nvim'))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has('termguicolors'))
  set termguicolors
endif

set background=dark           " Enable dark background
colorscheme onedark "Set the colorscheme
syntax sync minlines=200
set foldmethod=manual


""
"" Plugins
""

fun! s:git_root()
	let l:path = finddir('.git', expand('%:p:h').';')
	return fnamemodify(substitute(l:path, '.git', '', ''), ':p:h')
endfun



" Grepper
runtime plugin/grepper.vim

let g:grepper.dir = 'repo,file'
let g:grepper.open = 1
let g:grepper.tools =
  \ ['rg', 'git', 'grep']

let g:grepper.rg.grepprg .= ' --type-add slim:*.slim --type-add haml:*.haml -g "!{.git,node_modules,vendor,build,tmp,yarn.lock,*.sty}/*"'

map <leader>a :GrepperRg<Space>

" Quickfix Window
nmap <leader>qf <Plug>QfCtoggle
let g:qf_mapping_ack_style = 1

" Nerdtree
nnoremap <silent> <leader>e :NERDTreeFind<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<CR>
let NERDTreeMapOpenVSplit = 'v'

" Close buffer
map <leader>q :Sayonara!<CR>
map <leader>Q :bufdo Sayonara!<CR>

" Fugitive mapping

" make fugitive work on empty buffers

nmap <leader>gb :Gblame<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gg :Ggrep
nmap <leader>gl :Glog<CR>
nmap <leader>gw :Gbrowse<CR>

" Get current branch
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! PullCurrentBranch()
  let l:branch = GitBranch()
  exe ':Git pull origin ' . l:branch
endfunction

function! PushCurrentBranch()
  let l:branch = GitBranch()
  exe ':Git push origin ' . l:branch
endfunction

nmap <leader>gP :call PullCurrentBranch()<CR>
nmap <leader>gp :call PushCurrentBranch()<CR>

" Git status hacks

nmap <leader>gs :Gtabedit :<CR>

function! GStatusTabDiff()
  if has('multi_byte_encoding')
    let l:colon = '\%(:\|\%uff1a\)'
  else
    let l:colon = ':'
  endif
  let l:filename = matchstr(matchstr(getline(line('.')),'^#\t\zs.\{-\}\ze\%( ([^()[:digit:]]\+)\)\=$'), l:colon.' *\zs.*')
  tabedit %
  execute ':Gedit ' . l:filename
  Gvdiff
endfunction

" startify
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
let g:startify_relative_path = 1
let g:startify_list_order = [
      \ ['   Sessions:'],
      \ 'sessions',
      \ ['   Recent files:'],
      \ 'files',
      \ ['   Recent files in current directory:'],
      \ 'dir',
      \ ]

" Ripgrep
" --files: List files that would be searched but do not search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor,build,tmp,yarn.lock,*.sty}/*"'

" Fd
" --type file: only list files as result
" --no-ignore: do not ignore .gitignore
" --exclude: manually exclude folders
let $FZF_DEFAULT_COMMAND = "fd . --type file --hidden --no-ignore --exclude '{.git,doc*/,node_modules,vendor,build,tmp,*.sty}'"

let g:fzf_buffers_jump = 1  " [Buffers] Jump to the existing window if possible

nnoremap <silent> <C-P> :exe 'Files ' . <SID>git_root()<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <C-R> :BTags<CR>

" Vim Test
map <silent> <leader>ft :TestFile<CR>

if has('nvim')
  " run tests with :T
  let test#strategy = 'neoterm'

  let g:neoterm_default_mod = 'vertical'

  " pretty much essential: by default in terminal mode, you have to press ctrl-\-n to get into normal mode
  " ain't nobody got time for that
  tnoremap <Esc> <C-\><C-n>
endif

" Deoplete
let g:deoplete#enable_at_startup = 0

" Ultisnips
set shortmess+=c
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
"inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

" Better whitespace

" Merginal
noremap <leader>m :Merginal<CR>

" Easy motion
map <Leader> <Plug>(easymotion-prefix)


" " Gutentags
let g:gutentags_define_advanced_commands = 1
nnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>


" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:ale_linters = {
\  'jsx':        ['eslint'],
\  'javascript': ['eslint']
\}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '!'

" FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" EasyMotion
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f2)
omap s <Plug>(easymotion-overwin-f2)
xmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\

if has('nvim')
    " Sane terminal bindings
    tnoremap <Esc> <C-\><C-n>
    tnoremap <leader><esc> <esc>
    " nnoremap <bs> <c-w>h
    let g:terminal_scrollback_buffer_size = 10000
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    set inccommand=nosplit
else
    set encoding=utf-8
endif

nnoremap H :HisTravBack<CR>
nnoremap L :HisTravForward<CR>
