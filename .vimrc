" FORMATTERS
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css


"VimMap Keys
"
nmap <leader>ue :UltiSnipsEdit<cr>
map <C-t><up> :tabr<cr>

map <C-t><down> :tabl<cr>

map <C-t><left> :tabp<cr>

map <C-t><right> :tabn<cr>
nnoremap <leader>l :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
"map <C-p> :FZF<CR>
map <C-n> :NERDTreeToggle<CR>
nnoremap <F5> mzgggqG`z
"Vim Plug
call plug#begin('~/.vim/plugged')
Plug 'sirver/ultisnips'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()
"Vim config
"NerdTree Ignore
let g:NERDTreeIgnore = ['^node_modules$']
"set UltiSnips 
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"set auto format prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
"set the eslint config
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint'],
\   'vue': ['eslint']
\}

let g:ale_fixers = {
  \    'javascript': ['eslint'],
  \    'typescript': ['prettier', 'tslint'],
  \    'vue': ['eslint'],
  \    'scss': ['prettier'],
  \    'html': ['prettier'],
  \    'reason': ['refmt']
\}
let g:ale_fix_on_save = 1
"set the language servers
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
"set the with of tabstop to 4 spaces
set tabstop=4
"make indentation to correnspond to one tab
set shiftwidth=4
"Allow line numbers
set number
"Always display the status line
set laststatus=2
"Don't try to be compatible with Vi
set nocompatible
"Show typing cmd
set showcmd
"Turn syntax highlighting on for programing
syntax on
"Detect file types
filetype plugin indent on
"Use utf-8 Encoding
set encoding=utf-8
"Choose theme for airline
let g:airline_theme='powerlineish'
"Choose icons for airline bar
let g:Powerline_symbols='unicode'
"Choose fonts for airline theme
let g:airline_powerline_fonts = 1
"Enable 256 colors
"Enable gruvbox
colorscheme gruvbox
"set Dark mode
set bg=dark
"Add warnings to status bar
set statusline+=%#warningmsg#
"Gice syntastic access to the status line
"Back to normal color
set statusline+=%*
"Always populate location list with errors
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"check for errors on open ad on sabe exit
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"Use eslint with syntastic
let g:syntastic_javascript_checkers = ['eslint']
"Disable airline tagbar for faster opening times
let g:airline#extensions#tagbar#enabled = 0
"Open Nerdtree automatically when vim starts up opining a directory
"I usually start working by navigating to the folder and typing [vim .]
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif"Build Fuzzy Finder
"Search and autocomplete into subfolders
set path+=**
"Append to existing value of path
"the 2 stars tells vim to search Subdirectorties recursively in the folder vim is running"Use Tab for auto completion
set wildmenu
"FZF ignore node_modul
" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()
