""""""""""""
" Vim Plug "
""""""""""""
set nocompatible " required

" https://github.com/junegunn/vim-plug

" Automatic install
if !has("nvim") && empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup InstallingPlugs
        autocmd!
        autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup END
elseif has("nvim") && empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup InstallingPlugs
        autocmd!
        autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup END
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

""""""""""""""""
" File Finding "
""""""""""""""""
Plug 'scrooloose/nerdtree'

"""""""""""""
" Syntax Highlighting "
"""""""""""""
if !has('nvim')
    Plug 'scrooloose/syntastic'
else
    " Async highlighting
    Plug 'neomake/neomake'
endif

"""""""""""
" Styling "
"""""""""""
" Monokai
Plug 'sickill/vim-monokai'

" LightLine
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Tmux line
Plug 'edkolev/tmuxline.vim'

"""""""""""""
" Languages "
"""""""""""""

" Javascript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }

" Javascript doc tool
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx'] }

" Jsx
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }
" allows for .js files to use this package, important for react native
let g:jsx_ext_required = 0

" Stylus
Plug 'wavded/vim-stylus', { 'for': 'stylus' }

" Python thing
Plug 'hynek/vim-python-pep8-indent'

" Markdown
Plug 'plasticboy/vim-markdown'

" Elm
Plug 'elmcast/elm-vim'


""""""""""""""""""""
" Navigation Tools "
""""""""""""""""""""
" Fuzzy finder
if has("gui_running")
    " plugin to control p
    Plug 'ctrlpvim/ctrlp.vim'
    " plugin to speed up control p
    Plug 'FelikZ/ctrlp-py-matcher'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
endif

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

if has('nvim')
    " incremental substitution when changing text with %s, you see it in a split
    set inccommand=split
endif

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

""""""""""""""""""""
" * Plugin Mods  * "
""""""""""""""""""""
" File Navigation tools (if gui we need a different one)
if has("gui_running")
    """""""""""""""""""""""""""
    " Modifications for CTRLP "
    """""""""""""""""""""""""""
    nnoremap <silent> <leader>l :CtrlPMRU<CR>
    nnoremap <silent> <leader>b :CtrlPBuffer<CR>
    nnoremap <silent> <leader>t :CtrlPTag<cr>
    let g:ctrlp_map = '<leader>p'
    let g:ctrlp_cmd = 'CtrlP'

    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    let g:ctrlp_use_caching = 0
else
    """""""""""""""""""""""""
    " Modifications for FZF "
    """""""""""""""""""""""""
    nnoremap <silent> <C-p> :GitFiles<CR>
    nnoremap <silent> <leader>l :History<CR>
    nnoremap <silent> <leader>t :Tags<CR>
    nnoremap <silent> <leader>b :BTags<CR>
endif

" wildcard
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
augroup StripWhiteSpace
    autocmd!
    autocmd BufWritePre *.py,*.js,*.coffee :call <SID>StripTrailingWhitespaces()
augroup END

"""""""""""""
" Syntax Highlighting "
"""""""""""""
if has('nvim')
    """""""""""
    " Neomake "
    """""""""""
    " Python
    let g:neomake_python_enabled_makers = ['flake8']
    " Ignore errors
    let g:neomake_python_flake8_args = ['--max-line-length=200', '--ignore=W391']

    " Javascript
    let g:neomake_javascript_enabled_makers = ['eslint']

    augroup RunNeomake
        autocmd!
        autocmd BufWritePost * Neomake
    augroup END
else
    """""""""""""
    " Syntastic "
    """""""""""""
    " for syntastic use f12
    let g:syntastic_mode_map = { 'mode': 'active' }
    nnoremap <F10> :SyntasticToggleMode<CR>
    " Toggles Syntax check
    nnoremap <F12> :update<CR>:SyntasticCheck<CR>

    " Fun styling for syntastic
    let g:syntastic_error_symbol = '❌ '
    let g:syntastic_style_error_symbol = '⁉️'
    let g:syntastic_warning_symbol = '⚠️'
    let g:syntastic_style_warning_symbol = '💩 '

    " Javascript
    let g:syntastic_javascript_checkers = ['eslint']

    " Python
    let g:syntastic_python_checkers = ["flake8"]

    " Ignore Errors
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

""""""""""""""
" vim js-doc "
""""""""""""""
" Turn on es6 syntax
let g:jsdoc_enable_es6 = 1
" Allow prompt for interactive input
let g:jsdoc_allow_input_prompt = 1
" this adds in the function name
let g:jsdoc_additional_descriptions = 1
" The character after the param name
let g:jsdoc_param_description_separator = " - "
" Prompt for a function description
let g:jsdoc_input_description = 1
" underscore is private
let g:jsdoc_underscore_private = 1
nmap <silent> <leader>d <Plug>(jsdoc)

" mapping for NERDTree
noremap <Leader>f :NERDTree<CR>

" setting things up for netrw, this is basically the same as NERDTree but a
" little slower
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
" this command would open the drawer every time I open vim
"augroup ProjectDrawer
    "autocmd!
    "autocmd VimEnter * :Vexplore
"augroup END
