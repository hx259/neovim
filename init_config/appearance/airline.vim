let g:airline#extensions#tabline#enabled = 1        " display all buffers
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

set showtabline=2                     							" show tabline at upleft corner
set showmode                          							" i.e. show things like -- INSERT --

let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])		" make the status line to look like powerline
