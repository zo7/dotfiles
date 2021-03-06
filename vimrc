"           __
"   .--.--.|__|.--------.----.----.
"  _|  |  ||  ||        |   _|  __|
" |__\___/ |__||__|__|__|__| |____|
"

" --- load plugins

" Automatic install plug.vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/nerdtree'
Plug 'psf/black'
Plug 'vim-python/python-syntax'
Plug 'w0rp/ale'

call plug#end()

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

let NERDTreeIgnore = ['\.pyc$', '\.egg-info$']

" use plain characters instead of arrows (no fun over ssh)
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let g:ale_lint_on_enter = 1
let g:ale_lint_delay = 100
let g:ale_linters = {
\   'python': ['flake8'],
\   'typescript': [],
\}

let b:ale_linters = ['flake8']
let b:ale_fixers = {'python': ['black']}
let g:ale_fix_on_save = 1

set laststatus=2
set noshowmode

"autocmd User ALELint call s:MaybeUpdateLightline()

function! s:MaybeUpdateLightline()
    if exists('#lightline')
        call lightline#update()
    end
endfunction

let g:python_highlight_builtins = 1

let g:completor_python_binary = '~/.pyenv/shims/python'

" --- general

set regexpengine=1
syntax on
set number
set ts=4 sw=4 sts=4
set expandtab
set backspace=indent,eol,start
set hlsearch

" use special characters for tabs and trailing whitespace
set listchars=tab:<-,trail:-

set cc=80
hi ColorColumn ctermbg=7

" wrap text, don't linebreak by default
set wrap linebreak list
set textwidth=100
set wrapmargin=100
set formatoptions=l
set foldlevel=100
set foldmethod=syntax

" no characters or colors when splitting windows
set fillchars+=vert:\ 

" just underline misspelled words
hi clear SpellBad
hi SpellBad cterm=underline

" new windows open below and to the right
set splitbelow
set splitright

" true color
if v:version >= 800
    set termguicolors
    set t_Co=256
endif

" don't bold or italicize LaTeX
hi clear texItalStyle
hi clear texBoldStyle

" colorscheme
set background=dark
try
    colorscheme iceberg
    let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ }
catch
    " Do nothing
endtry


" --- key mappings

" move cursor by display line, rather than physical
nnoremap j gj
nnoremap k gk

" change window with C-<direction>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" also create windows by just holding ctrl
nnoremap <C-s> <C-w>s
nnoremap <C-v> <C-w>v

" use space to fold methods in normal/visual mode
nnoremap <space> za
vnoremap <space> zf

" better vim habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" terminal remaps
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l



" --- commands

" trim trailing whitespace
command! Trim %s/\s\+$//e


" --- etc

" generate help files
packloadall
silent! helptags ALL
