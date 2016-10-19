" Vundle
set nocompatible " required
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"""""""""""
" Plugins "
"""""""""""

"""""""""""
" Editing "
"""""""""""
" Server auto complete < no dependent files
Plugin 'ervandew/supertab'

""""""""""""""
" Commenting "
""""""""""""""
Plugin 'scrooloose/nerdcommenter'

"""""""""""
" Styling "
"""""""""""
" Monokai
Plugin 'sickill/vim-monokai'

" CoffeeScript
Plugin 'kchmck/vim-coffee-script'

" CJSX
Plugin 'mtscout6/vim-cjsx'

" Stylus
Plugin 'wavded/vim-stylus'

" Elm
Plugin 'elmcast/elm-vim'

""""""""""""""""""""
" Navigation Tools "
""""""""""""""""""""
" plugin to control p
Plugin 'ctrlpvim/ctrlp.vim'
" plugin to speed up control p
Plugin 'FelikZ/ctrlp-py-matcher'

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required

"Colors
syntax enable
colorscheme monokai

" Formatting
set fileformat=unix " Make sure the files are always unix
set fileformats=unix " Make sure the files are always unix
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " number of spaces when ?
set expandtab " tabs are spaces (tab button = spaces)
set colorcolumn=80 " keep within this column

" UI stuff
set number " show line nums
set showcmd " show last entered command
set cursorline " highlight current line
filetype indent on " load filetype-specific indent files
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to.
set showmatch " show matching ()
set mouse=a " Turn on mouse mode

" keyboard stuff
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap jj <ESC> " Some people say this helps speed up normal mode
set scrolloff=5 " Makes the cursor offset

" search stuff
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase
set smartcase

" best leader
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>

" elm formatting
let g:elm_format_autosave = 1
let g:elm_make_show_warnings = 1
nnoremap <Leader>m :ElmMake<CR>
nnoremap <Leader>e :ElmErrorDetail<CR>

"Paste toggle
set pastetoggle=<F2>

" f3 will toggle linenumbers
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

" Remove those ^M characters
nnoremap <silent> <leader>6 :%s///g<CR>

"""""""""""""""""""""""""""
" Modifications for CTRLP "
"""""""""""""""""""""""""""
"Accessing mru mode
nnoremap <silent> <leader>l :CtrlPMRU<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>t :CtrlPTag<cr>

" Silver Searcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
set wildignore+=*/tmp/*,**/css/*,
    \*/cc/*,*.so,*.swp,*.zip,*.pyc,*/.git

"""""""""""""""""
" Auto Commands "
"""""""""""""""""
" auto cmd to strip whitespace
"autocmd BufWritePre * :%s/\s\+$//e
function! <SID>StripTrailingWhitespaces()
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
autocmd BufWritePre *.py,*.js,*.coffee :call <SID>StripTrailingWhitespaces()
