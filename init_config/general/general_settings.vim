au! BufWritePost $MYVIMRC source % " auto source when writing into init.vim

syntax on                          " syntax highlight on
filetype indent on                 " automatic indent according to file type

set nocompatible                   " use this .vim setting instead of compatible mode
set number                         " show line number
" set relativenumber               " show relative line number
set noerrorbells                   " turn of the beeping from error message
set showcmd                        " show the command typed
set mouse=a                        " enable mouse in all modes
set t_Co=256                       " use vim with 256 colors
set autoindent                     " automatic indent
set tabstop=2                      " 1 tab = 2 columns
set shiftwidth=2                   " level of indentation
" set cursorline                   " highlight the current line
set ruler                          " show cursor location at downright corner
set wrap                           " text wrap
set wrapmargin=2                   " wrap margin from the right border
set linebreak                      " linebreak without breaking the word
set ignorecase                     " ingore case-sensitivity in searching
set smartcase                      " allow case-sensitivity if contains Uppercase
set scrolloff=3                    " large number centers the cursor vertically
set laststatus=2                   " always show statusline
set autoread                       " auto-read when the file is changes on disk
set wildmenu                       " auto-complete commands
set wildmode=list:full             " auto-complete filenames in commands
set showmatch                      " highlight the matching brackets
set hlsearch                       " highlight search
set incsearch                      " highlight all matching searchs
set list                           " display otherwise invisible characters
set listchars=tab:\ \ ,trail:·     " display trails only
set complete+=kspell               " spell completion
set encoding=UTF-8                 " displayed encoding
set fileencoding=UTF-8             " encoding written to file
set nohidden                       " don't keep multiple buffers without saving
set path+=**                       " find every file recursively based on current directory
set pumheight=10                   " popup menu size
" set conceallevel=                " set to 1 to conceal text in latex
set nobackup                       " recommended by coc
set nowritebackup                  " recommended by coc
set clipboard=unnamedplus          " copy & paste between vim and others
