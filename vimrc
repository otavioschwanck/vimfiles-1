" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

silent! runtime bundles.vim

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

silent! runtime bundles.vim

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

filetype plugin indent on
let mapleader = "\\"
let g:mapleader = "\\"
syntax enable

" do not create backup, swap file, use git for version managment
set nobackup
set nowritebackup
set noswapfile

" This means that you can have unwritten changes to a file and open a new file
" using :e, without being forced to write or undo your changes first.
set hidden

set history=1000  "store lots of :cmdline history

" Powerline
let g:Powerline_symbols = 'fancy'

" ---------------------------------------------------------------------------
" UI
" ---------------------------------------------------------------------------

set title				 " make your xterm inherit the title from Vim
set encoding=utf-8
set autoindent
set smartindent
set showmode     " show current mode down the bottom
set showcmd      " show incomplete cmds down the bottom
set hidden			 " hides buffers instead of closing them
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline	 " highlight current line
set ttyfast
set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set laststatus=2 " display the status line always
set number			 " display the numbers

" some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

" ---------------------------------------------------------------------------
" Text Formatting
" ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2

set nowrap
set textwidth=79
set formatoptions=n

" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

" \a to Ack (search in files)
nnoremap <leader>a :Ack
nnoremap <leader>f :CtrlP<cr>

"Key mapping for textmate-like indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" turn search highlight off
nnoremap <leader><space> :noh<cr>

" Tabularize
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" ---------------------------------------------------------------------------
" Ruby/Rails
" ---------------------------------------------------------------------------

map <leader>gv :CtrlP app/views<cr>
map <leader>gc :CtrlP app/controllers<cr>
map <leader>gm :CtrlP app/models<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>gl :CtrlP lib<cr>
map <leader>gp :CtrlP public<cr>
map <leader>gs :CtrlP public/stylesheets<cr>
map <leader>ga :CtrlP app/assets<cr>

" Skip to Model, View or Controller
map <Leader>m :Rmodel
map <Leader>v :Rview
map <Leader>c :Rcontroller

" Execute current buffer as ruby
map <S-r> :w !ruby<CR>

" View routes or Gemfile in large split
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

" NERDTree
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 30
let NERDTreeChDirMode = 2
let NERDTreeDirArrows = 1
silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>

" NERDCommenter mappings
if has("gui_macvim") && has("gui_running")
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i
else
  map <leader>/ <plug>NERDCommenterToggle<CR>
  imap <leader>/ <Esc><plug>NERDCommenterToggle<CR
endif

" Tagbar
map <leader>l :TagbarToggle <cr>
let g:tagbar_autofocus=1

" Generate ctags for all bundled gems as well
map <leader>rt :!ctags --extra=+f --languages=-javascript --exclude=.git --exclude=log -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

" Use only current file to autocomplete from tags
" set complete=.,t
set complete=.,w,b,u,t,i

" ---------------------------------------------------------------------------
" Functions
" ---------------------------------------------------------------------------

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
		" Only strip whitespace if isn't a slim or haml file
		if &filetype =~ 'slim' || &filetype =~ 'haml'
		  return
		endif
		" Preparation: save last search, and cursor position.
		let _s=@/
		let l = line(".")
		let c = col(".")
		" Do the business:
		%s/\s\+$//e
		" Clean up: restore previous search history, and cursor position
		let @/=_s
		call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" ---------------------------------------------------------------------------
" GUI
" ---------------------------------------------------------------------------

" colorscheme
color solarized

if has("gui_running")
  set guioptions-=T " no toolbar set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions-=L "no scrollbar on the nerdtree"

  "tell the term has 256 colors
   set t_Co=256

  set guitablabel=%M%t

  if has("gui_gnome")
    set term=gnome-256color
    set guifont=Monospace\ Bold\ 12
  endif

  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif

  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
    set enc=utf-8
  endif
else
	"dont load csapprox if there is no gui support - silences an annoying warning
	let g:CSApprox_loaded = 1

	"set railscasts colorscheme when running vim in gnome terminal
	if $COLORTERM == 'gnome-terminal'
		set term=gnome-256color
	else
		if $TERM == 'xterm'
			set term=xterm-256color
		else
			colorscheme molokai
		endif
	endif
endif

" listchars only for slim and haml files
autocmd BufNewFile,BufRead *.slim,*.haml setlocal list listchars=extends:>,precedes:<,eol:¬

" load custom configs
if filereadable(expand("$HOME/") . '.vimrc.local')
  source ~/.vimrc.local
endif
