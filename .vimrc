"-------------------- options --------------------
set nocompatible

" remap splitting window
noremap <leader>s :sp<CR>-
noremap <leader>v :vsp<CR>-

" enable syntax coloring
syntax enable

" enable mouse
:set mouse=a

" show line numbers
set number

" number of spaces that tab in the file counts for
set ts=4

" number of spaces to use for each step if (auto)indent
set sw=4

" use spaces instead of tabs
set et

" set color of the background
set background=dark

" set number of terminal colors
set t_Co=256

" do smart autoindenting when starting new line
set si

" highlight search pattern
set hlsearch

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" if hidden is not set, TextEdit might fail.
set hidden

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Better display for messages
set cmdheight=2

"-------------------- vim-plug --------------------
" avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" ctrlp
Plug 'ctrlpvim/ctrlp.vim'

" nerdtree
Plug 'scrooloose/nerdtree'

" solarized
Plug 'altercation/solarized', { 'rtp': 'vim-colors-solarized' }

" fugitive
Plug 'tpope/vim-fugitive'

" nerdcommenter
Plug 'scrooloose/nerdcommenter'

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" indent-guides
Plug 'nathanaelkane/vim-indent-guides'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

"-------------------- ctrlp --------------------
" custom ignore
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target'

"-------------------- nerdtree --------------------
" toggle on ctrl-n
map <C-n> :NERDTreeToggle<CR>

" close vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"-------------------- solarized --------------------
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
let g:solarized_contrast='high'
colorscheme solarized

"-------------------- nerdcommenter --------------------
" map comments to enter
nnoremap <C-m> :call NERDComment(0,"toggle")<C-m>

"-------------------- editorconfig --------------------
" ensures that this plugin works well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

"-------------------- airline --------------------
" display all buffers
let g:airline#extensions#tabline#enabled = 1

" set the theme
let g:airline_theme='solarized'

"-------------------- indent-guides --------------------
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 4

" enable by default
let g:indent_guides_enable_on_vim_startup = 1

" custom colors
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#121212 ctermbg=236

"-------------------- coc --------------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
