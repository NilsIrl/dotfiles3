set termguicolors

let g:gruvbox_italic=1
set bg=light
colorscheme gruvbox

set mouse=a
set number relativenumber

set wildmode=longest:full,full

nnoremap <silent> Y y$
set inccommand=nosplit

set undofile

set completeopt+=menuone,noinsert,noselect
set shortmess+=c

set tabstop=4 shiftwidth=4 expandtab

set hidden

function! PackInit() abort
	packadd minpac
	call minpac#init()

	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('morhetz/gruvbox')

	call minpac#add('rust-lang/rust.vim')
	call minpac#add('LnL7/vim-nix')
	call minpac#add('cespare/vim-toml')

	call minpac#add('editorconfig/editorconfig-vim')

	call minpac#add('junegunn/fzf', {'do': {-> system('./install --all')}})
	call minpac#add('junegunn/fzf.vim')

	call minpac#add('jeffkreeftmeijer/vim-numbertoggle')
	call minpac#add('christoomey/vim-tmux-navigator')
	call minpac#add('glacambre/firenvim', { 'type': 'opt', 'do': 'packadd firenvim | call firenvim#install(0)'})

	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-repeat')

	call minpac#add('easymotion/vim-easymotion')

	call minpac#add('mbbill/undotree')

	call minpac#add('norcalli/nvim-colorizer.lua', {'type': 'opt'})

	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-rhubarb')

	call minpac#add('neovim/nvim-lspconfig', {'type': 'opt'})
	call minpac#add('nvim-lua/completion-nvim', {'type': 'opt'})
	call minpac#add('nvim-treesitter/nvim-treesitter', {'type': 'opt', 'do': 'packadd nvim-treesitter | TSUpdate'})

	call minpac#add('SirVer/ultisnips')

	call minpac#add('godlygeek/tabular')
endfunction

" easymotion

map <Leader>f <Plug>(easymotion-bd-f)

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
nnoremap <Leader>nf <Cmd>Files<CR>
nnoremap <Leader>ng <Cmd>GitFiles<CR>

" minpac

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" nvim-colorizer.lua

packadd nvim-colorizer.lua
lua require 'colorizer'.setup()

" LSP

packadd nvim-lspconfig
lua require 'lspconfig'.rust_analyzer.setup{}
lua require 'lspconfig'.texlab.setup{}
lua require 'lspconfig'.clangd.setup{}

packadd nvim-treesitter

lua <<EOF
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp", "rust", "json", "nix"},
  highlight = {
    enable = true
  },
  indent = {
  	enable = true
  }
}
EOF

let g:completion_enable_snippet = 'UltiSnips'
packadd completion-nvim
autocmd BufEnter * lua require 'completion'.on_attach()

nnoremap <silent> <C-]> <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <Cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> 1gD <Cmd>lua vim.lsp.buf.type_definition()<CR>

" rust.vim

let g:rustfmt_autosave = 1

" vim-tmux-navigator

let g:tmux_navitor_no_mappings = 1
nnoremap <silent> <M-h> <Cmd>TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> <Cmd>TmuxNavigateDown<CR>
nnoremap <silent> <M-k> <Cmd>TmuxNavigateUp<CR>
nnoremap <silent> <M-l> <Cmd>TmuxNavigateRight<CR>
nnoremap <silent> <M-\> <Cmd>TmuxNavigatePrevious<CR>
