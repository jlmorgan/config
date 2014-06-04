" Reference - http://vimdoc.sourceforge.net/htmldoc/options.html
" General
set autoread        " Autoread when a file is changed outside of the editor
set encoding=utf-8  " Set encoding
set hidden          " Manage multiple buffers
set history=1000    " Longer command history
set magic           " Enable regular expression special characters
set nobackup        " Disable back ups since we have source control
set nocompatible    " Disable compatibility mode
set noswapfile      " Disable swap file
set shell=/bin/bash " Shell
syntax on           " Syntax highlighting

" Searching
set hlsearch   " Highlight search results
set incsearch  " While typing a search pattern, show where the pattern is as it is typed
set ignorecase " Ignore cases of searches
set smartcase  " Ignore case in the search pattern

" Tabbing and Indention
set autoindent   " Enable auto-indenting
set expandtab    " Turn tabs into spaces
set shiftwidth=2 " Set indenting to 2 spaces
set smartindent  " Enable smart indention
set smarttab     " Enable smart tabbing
set tabstop=2    " Set tab stop to 2

" UI
set cmdheight=2           " Number of screen lines to use for the command line
set laststatus=2          " Always display status (0: never, 1: only when 2+ windows, 2: always)
set lazyredraw            " Don't redraw while executing macros
set number                " Enable line numbering
set ruler                 " Show the line and column number of the cursor position
set scrolloff=3           " Lines above and below the cursor
set showmatch             " Enable display of matching open/close brackets, parens, etc.
set title                 " Set the title of the terminal while editing
set wildmenu              " Enable tab completion
set wildmode=list:longest " When more than one match, list all matches and complete till longest common string
set visualbell            " Enable the visual bell for error events

" Visual Mode
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Number toggle
nnoremap <F3> :set number!<LF>

" Enable open/close matching
runtime macros/matchit.vim

if has('vim_starting')
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Custom Bundles:
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rstacruz/sparkup', { 'rtp': 'vim/' }
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'airblade/vim-gitgutter'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Required:
" Enable loading the indent file
" Enable loading the plugin file
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

let g:airline_powerline_fonts = 1
