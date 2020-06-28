set termguicolors
colorscheme gruvbox

set mouse=a
set number relativenumber

set wildmode=longest:full,full

nnoremap <silent> Y y$
set inccommand=nosplit

set undofile

function! PackInit() abort
	packadd minpac
	call minpac#init()

	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('morhetz/gruvbox')

	call minpac#add('rust-lang/rust.vim')
	call minpac#add('LnL7/vim-nix')

	call minpac#add('junegunn/fzf', {'do': {-> system('./install --all')}})
	call minpac#add('junegunn/fzf.vim')

	call minpac#add('jeffkreeftmeijer/vim-numbertoggle')
	call minpac#add('christoomey/vim-tmux-navigator')
	call minpac#add('glacambre/firenvim', { 'type': 'opt', 'do': 'packadd firenvim | call firenvim#install(0)'})

	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-repeat')

	call minpac#add('norcalli/nvim-colorizer.lua', {'type': 'opt'})

	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-rhubarb')

	call minpac#add('SirVer/ultisnips')
	call minpac#add('godlygeek/tabular')
endfunction

" firenvim

if exists('g:started_by_firenvim')
	let g:firenvim_config = {
				\ 'localSettings': {
				\ 	'.*': {
				\ 		'selector': 'textarea',
				\ 		'priority': 0
				\ 	}
				\ }
			\ }
	set laststatus=0
	autocmd BufEnter github.com_*.txt set filetype=markdown
	autocmd BufEnter play.rust-lang.org_*.txt set filetype=rust
	nnoremap <expr> <Esc> firenvim#focus_page()
	packadd firenvim
endif

" FZF

autocmd! FileType fzf set laststatus=0 noruler noshowmode norelativenumber | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <Leader>nf :Files<CR>
nnoremap <Leader>nt :Tags<CR>

" minpac

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" nvim-colorizer.lua

packadd nvim-colorizer.lua
lua require 'colorizer'.setup()

" rust.vim

let g:rustfmt_autosave = 1

" vim-tmux-navigator

let g:tmux_navitor_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
nnoremap <silent> <M-\> :TmuxNavigatePrevious<CR>
