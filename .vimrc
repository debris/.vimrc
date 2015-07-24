"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" setup vundle and plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible		" be iMproved, required
filetype off			" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" install nerdtree
Plugin 'The-NERD-tree'

" install nerdtree commenter
Plugin 'The-NERD-Commenter'

" install languages support
Plugin 'vim-polyglot'

" install colors package
Plugin 'vim-colors-solarized'

" install git helper
Plugin 'vim-fugitive'

" Fuzzy file, buffer, mru etc. (finder)
Plugin 'ctrlp.vim'

" Ligth powerline!
Plugin 'vim-airline'

" syntax checker
" commented out until figure out, how to use it
"Plugin 'syntastic'

" colorfull indention
Plugin 'vim-indent-guides'

" shows git diff in the gutter
Plugin 'vim-gitgutter'

" autocompletion!
Plugin 'YouCompleteMe'

" tern!
Plugin 'tern_for_vim'

" solidity syntax!
Plugin 'vim-solidity'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" configure globals and plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""" GLOBAL

" enable mouse in iTerm on MacOS
:set mouse=a

" enable coloring syntax
syntax enable

" show line numbers
set number

" do smart autoindenting when starting a new line.
set si

" number of spaces that a <Tab> in the file counts for.
set ts=4

" number of spaces to use for each step if (auto)indent
set sw=4

" use spaces instead of tabs
set et

" set background to dark (characters will be light)
set background=dark

" set foreground color to 256
set t_Co=256

" highlight search pattern
set hlsearch

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

""" The-NERD-tree

" open nerdtree on start
"autocmd vimenter * NERDTree

" toggle nerdtree on ctrl-n
map <C-n> :NERDTreeToggle<CR>

" do not use fancy arrows
let g:NERDTreeDirArrows=0



""" The-NERD-Commenter

" map comments to enter
nnoremap <C-m> :call NERDComment(0,"toggle")<C-m>



""" vim-colors-solarized

" old-setup
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
let g:solarized_contrast='high'
colorscheme solarized

""" vim-airline
" aka powerline

" display all buffers
let g:airline#extensions#tabline#enabled = 1



""" syntastic

" recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



""" vim-indent-guides

" old-setup
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 4
let g:indent_guides_color_change_percent = 10

autocmd BufReadPre,FileReadPre * :IndentGuidesEnable
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#121212 ctermbg=236