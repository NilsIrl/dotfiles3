set termguicolors
colorscheme gruvbox

set mouse=a
set number relativenumber

nnoremap <silent> Y y$
set inccommand=nosplit

function! PackInit() abort
	packadd minpac
	call minpac#init()

	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('morhetz/gruvbox')

	call minpac#add('rust-lang/rust.vim')
	call minpac#add('LnL7/vim-nix')

	call minpac#add('junegunn/fzf', {'do': {-> system('./install --all')}})
	call minpac#add('junegunn/fzf.vim')

	call minpac#add('christoomey/vim-tmux-navigator')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-repeat')

	call minpac#add('norcalli/nvim-colorizer.lua', {'type': 'opt'})
endfunction

" minpac

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" nvim-colorizer.lua

packadd nvim-colorizer.lua
lua require 'colorizer'.setup()

" vim-tmux-navigator

let g:tmux_navitor_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>

" FZF

autocmd! FileType fzf set laststatus=0 noruler noshowmode norelativenumber | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <leader>nf :Files<CR>
