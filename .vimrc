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

" you will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" if hidden is not set, TextEdit might fail.
set hidden

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" better display for messages
set cmdheight=3

" color column at 120 to avoid going to far to the right
set colorcolumn=120

" set to auto read when a file is changed from the outside
set autoread

" show matching brackets
set showmatch

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

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

" goyo
Plug 'junegunn/goyo.vim'

" Initialize plugin system
call plug#end()

"-------------------- ctrlp --------------------
" custom ignore
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target'

"-------------------- nerdtree --------------------
" toggle on ctrl-n
map <C-n> :NERDTreeToggle<CR>

" find on ctrl-j
map <C-j> :NERDTreeFind<CR>

" display hidden files
" let NERDTreeShowHidden=1

" close vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" always open nerdtree when booting vim, but do not focus on it
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" do not display useless files
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

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

" add coc extensions
call coc#add_extension("coc-rust-analyzer", "coc-json", "coc-html", "coc-snippets")

" enable cargo watch by default
call coc#config("rust-analyzer.enableCargoWatchOnStartup", "enabled")

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

" cargo watch
command! -nargs=0 Cstatus       :call CocAction("runCommand", "rust-analyzer.analyzerStatus")
command! -nargs=0 Cstop         :call CocAction("runCommand", "rust-analyzer.stopCargoWatch")

"-------------------- goyo --------------------
" set number of columns
let g:goyo_width=120

function! s:goyo_enter()
    set number
	if executable('tmux') && strlen($TMUX)
    	silent !tmux set status off
    	silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  	endif
endfunction

function! s:goyo_leave()
	if executable('tmux') && strlen($TMUX)
    	silent !tmux set status on
    	silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  	endif
endfunction

" set goyo callbacks
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" start distraction free writing on ctrl-g 
map <C-g> :Goyo<CR>
