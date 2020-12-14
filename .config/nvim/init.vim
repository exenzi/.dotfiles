let mapleader = ' '

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Lightline
" change color scheme
let g:lightline = {
	\'colorscheme': 'selenized_dark',
	\ }

if !has('gui_running')
    set t_Co=256
endif


" Settings
" ===============================================
" show relative line numbers
set number
set relativenumber

" split below/right
set splitbelow
set splitright

" turn off word wrap
set nowrap 

" required by coc
set hidden
set nobackup
set nowritebackup
set updatetime=300

" hide tilde blank lines
set fcs=eob:\ 



" Mappings
" ===============================================
" edit vim config
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" change focus to split 
nmap <C-H> <C-W><C-H>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>

" turn off highlight after search
nmap <Leader>h :nohlsearch<cr>

" coc completion
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
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
	call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Auto-Commands
" ===============================================
" auto source vimrc on save
" augroup! removes previos autocmd
augroup autosourcing
	autocmd!
	autocmd BufWritePost init.vim source %
augroup END
