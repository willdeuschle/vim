""""""""""""
" Vim Plug "
""""""""""""
set nocompatible " required

" https://github.com/junegunn/vim-plug

" Automatic install
if !has("nvim") && empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
elseif has("nvim") && empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Start plugin manager
 call plug#begin('~/.vim/plugged')

"""""""""""
" Plugins "
"""""""""""

"""""""""""
" Editing "
"""""""""""
" Server auto complete < no dependent files
Plug 'ervandew/supertab'

""""""""""""""
" Commenting "
""""""""""""""
Plug 'scrooloose/nerdcommenter'

"""""""""""""
" Syntastic "
"""""""""""""
Plug 'scrooloose/syntastic'

"""""""""""
" Styling "
"""""""""""
" Monokai
Plug 'sickill/vim-monokai'

" Stylus
Plug 'wavded/vim-stylus'

" Elm
Plug 'elmcast/elm-vim'

" LightLine
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

""""""""""""""""""""
" Navigation Tools "
""""""""""""""""""""
" plugin to control p
Plug 'ctrlpvim/ctrlp.vim'
" plugin to speed up control p
Plug 'FelikZ/ctrlp-py-matcher'

" Add plugins to &runtimepath
call plug#end()

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
"" new stuff for elm, trying
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1
""
nnoremap <Leader>m :ElmMake<CR>
nnoremap <Leader>e :ElmErrorDetail<CR>

"""""""""""""""""""""""
" Copying and pasting "
"""""""""""""""""""""""
" Reselecting Pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
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

"""""""""""""
" Syntastic "
"""""""""""""
if !has('nvim') " for syntastic use f12
    let g:syntastic_mode_map = { 'mode': 'active' }
    nnoremap <F10> :SyntasticToggleMode<CR>
    nnoremap <F12> :update<CR>:SyntasticCheck<CR>  " Toggles Syntax check

    " Fun styling for syntastic
    let g:syntastic_error_symbol = '❌'
    let g:syntastic_style_error_symbol = '⁉️'
    let g:syntastic_warning_symbol = '⚠️'
    let g:syntastic_style_warning_symbol = '💩'

    " Ignore Errors
    let g:syntastic_python_checkers = ["flake8"]
    let g:syntastic_python_flake8_args = '--max-line-length=200 --ignore=W391'
endif

"""""""""""
" Airline "
"""""""""""
" For Airline
set laststatus=2

" For Airline
let g:airline_powerline_fonts = 1

" For TMUX plugin
let g:tmuxline_powerline_separators = 1
