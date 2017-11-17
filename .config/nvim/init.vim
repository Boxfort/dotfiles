call plug#begin('~/.config/nvim/plugged')
Plug 'mhinz/vim-startify'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'dbgx/lldb.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'vim-latex/vim-latex'
Plug 'dracula/vim'
call plug#end()

call deoplete#enable()

" Airline Config
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 1
" End Airline Config

" GitGutter Config
let g:gitgutter_sign_column_always = 0
" End GitGutter Config

set rnu
set number
set list
color dracula
