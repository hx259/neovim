" GENERAL SETTINGS
source ~/.config/nvim/init_config/general/general_settings.vim

" PLUGINS
source ~/.config/nvim/init_config/plugins/plugins.vim

" APPEARANCE
source ~/.config/nvim/init_config/appearance/theme.vim
source ~/.config/nvim/init_config/appearance/airline.vim

"latex
source ~/.config/nvim/init_config/plugins/vimtex.vim
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0 "error window popup 试试开启
let g:vimtex_view_general_viewer = 'zathura' "pdf viewer for latex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr' "SyncTex location sync (neovim-remote)
"set conceallevel=1 "these two lines conceal the latex code
"let g:tex_conceal = 'abdmg'
let g:vimtex_toc_config = {
\ 'name': 'TOC',
\ 'layers': ['content', 'todo', 'include'],
\ 'split_width': 25,
\ 'todo_sorted': 0,
\ 'show_help': 1,
\ 'show_numbers': 1,
\}


" Colorschemes
"colorscheme cyberpunk
" Important!! (everforest)
"if has('termguicolors')
"    set termguicolors
"endif
" For dark version.
"set background=dark
" For light version.
"set background=light
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
"let g:everforest_background = 'soft'
"colorscheme everforest
