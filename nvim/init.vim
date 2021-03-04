call plug#begin('~/.config/nvim/plugged')
" Basic
Plug 'srcery-colors/srcery-vim' " Colorscheme
Plug 'tpope/vim-surround' " Mappings for dealing with surrounding characters
Plug 'tpope/vim-commentary' " Tools for easily commenting objects
Plug 'tpope/vim-fugitive' " Git plugin
Plug 'vim-airline/vim-airline' " Statusline
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy search
Plug 'airblade/vim-gitgutter' " Git diff info left of lines
" Plug 'vim-syntastic/syntastic' " Linting
Plug 'dense-analysis/ale'
Plug 'godlygeek/tabular' " Automatic tab alignment
Plug 'ludovicchabant/vim-gutentags' " Tags
Plug 'ervandew/supertab' " Tab completion

" Language Support
Plug 'lervag/vimtex' " LaTeX
Plug 'urso/haskell_syntax.vim' " Haskell Syntax Highlighting
Plug 'cespare/vim-toml' " TOML file highlighting
Plug 'gabrielelana/vim-markdown' " Markdown support
Plug 'rust-lang/rust.vim'
" F# support
Plug 'ionide/Ionide-vim', {
    \ 'do': 'make fsautocomplete',
    \ }

" Autocompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
     \ }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
Plug 'junegunn/fzf.vim'

" Misc.
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'} " Discord Rich Presence
call plug#end()

" Autocompletion settings
let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"

" Colorscheme configuration
set t_Co=256
colorscheme srcery

" Line numbers
set number
set relativenumber

" 4 Spaces
set softtabstop=4
set expandtab

" Tabs
" set autoindent
" set tabstop=4
" set noexpandtab

set shiftwidth=4

" Set leaderkey to ,
let mapleader=","

" Set local leaderkey to \
let localleader="\\"

let g:airline_powerline_fonts = 1
set shell=bash

" Vim-Tex settings
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

" Markdown Folding settings
let g:vim_markdown_folding_level = 3

" Configuration for Ocaml's Merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Language server set up
set hidden

let g:LanguageClient_autoStart = 1
" Use the location list instead of the quickfix list to show linter warnings
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_rootMarkers = {
    \ 'java': ['.git']
    \ }


let g:ale_linters = {'rust': ['analyzer', 'rustfmt']}
let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_fix_on_save = 1

call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'ocaml':  ['ocamllsp'],
    \ 'java': ['java-lsp.sh'],
    \ 'haskell': ['haskell-language-server-wrapper', '--lsp'],
    \ 'rust': ['rls']
\}

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

let g:discord_activate_on_enter = 1
