" --- DAD MODE VIM CONFIG ---

" 1. Basics
set number          " Show line numbers
set relativenumber  " Show relative numbers (Great for jumping: 'delete 5 lines down' is d5j)
set mouse=a         " Enable mouse (Click to move cursor, scroll wheel works)
set clipboard=unnamedplus " Use system clipboard (Copy/Paste works with outside world)

" 2. Visuals
syntax on           " Enable syntax highlighting
set cursorline      " Highlight the current line so you don't get lost

" --- MANUAL MODE: VISUALS ---
colorscheme gruvbox
set background=dark

" --- MANUAL MODE: STATUS BAR ---
" Vim finds the plugin automatically because it's in /start/
" We just need to configure it:

let g:airline_theme='gruvbox'         " Match your color scheme
let g:airline_powerline_fonts = 1     " Use the Nerd Font arrows
set laststatus=2                      " Always show the bar
set noshowmode                        " Hide the default --INSERT-- text
let g:airline#extensions#tabline#enabled = 1

" 3. Searching
set ignorecase      " Case insensitive search
set smartcase       " ...unless you type a capital letter
set incsearch       " Show search matches as you type

" 4. Tabbing (No more mixed tabs/spaces!)
set tabstop=4       " 4 spaces for a tab
set shiftwidth=4
set expandtab       " Convert tabs to spaces

" 5. Type 'jj' for <Esc>
inoremap jj <Esc>
