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

" --- Fixing the non-auto-overwrite of closing parentheses.
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" --- DAD MODE: LSP (INTELLISENSE) ---

" 1. Use Tab to trigger completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" 2. Use Enter to confirm selection
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Helper function for the Tab logic
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 3. Show documentation when pressing K (Like hovering mouse)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" --- GO (GOLANG) CONFIG ---

" 1. Map specific keys for Go files
autocmd FileType go nmap <leader>r :!go run %<CR>  " Leader+r runs the file
autocmd FileType go nmap <leader>b :!go build %<CR> " Leader+b builds it

" 1. Teach Vim that the sequence (Esc + e) is actually Alt+e
"    This uses 'execute' to safely handle the escape character.
execute "set <M-e>=\<Esc>e"

" 2. Now you can map Alt+e safely without breaking your normal Escape key
inoremap <silent><expr> <M-e> coc#pum#visible() ? coc#pum#cancel() : "\<M-e>"

" --- Use Windows system clipboard ---
let g:clipboard = {
    \   'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }

