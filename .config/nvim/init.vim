set termguicolors
set mouse=a
colorscheme gruvbox

function! PackInit() abort
	packadd minpac
	call minpac#init()

	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('morhetz/gruvbox')

	call minpac#add('rust-lang/rust.vim')
	call minpac#add('LnL7/vim-nix')

	call minpac#add('tpope/vim-surround')

	call minpac#add('norcalli/nvim-colorizer.lua', {'type': 'opt'})
endfunction

" minpac

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" nvim-colorizer.lua

packadd nvim-colorizer.lua
lua require 'colorizer'.setup()
