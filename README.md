## Optimal NEOVIM Configuration for *LaTex*, *MarkDown* and *C++* Coding

### Installation and Configuration

I use **Lazy** as plugin manager and **lua** for configuration. To change the configuration and plugin settings, check out `./init.lua` and `./lua/`

#### Prerequisites
The followings are needed, if not already installed:
- Get the newest version of nvim
- `sudo apt install texlive-full`
- `sudo apt install fzf`
- `sudo apt install ripgrep`

#### Font
I used JetBrainsMono Regular size 13, from Nerd Fonts. To install it:
- Get the fonts package from Nerd Fonts
- Unzip and copy these into `~/.local/share/fonts` and `/usr/local/share/fonts`
- run `fc-cache -f -v` to rebuild font cache

### Features

#### File Search and Navigation
- Open Neotree for filesystem navigation: `<Ctrl-n>`
- Find file: `<Alt-f>`
- Find (fuzzy) content with live grep: `<Alt-Shift-f>`

#### Code Navigation
***The `<leader>` key I use is `<Space>`.***
- Go to definition: `<leader>d`
- Hover for information: `<leader>h`
- Jump to the previous position: `<leader>-`
- Jump to the next position: `<leader>=`

#### Auto Completion
- `<Tab>` for accepting the snippet suggestion
- `<Alt-q>` for aborting current snippet suggestion
- Personalized snippets are stored in `~/.config/nvim/LuaSnip`

#### LaTex
- Build and watch in normal mode: `<leader>ll`  -> this will automatically build when changes are written
- Open the pdf viewer (zathura): `<leader>lv`

#### MarkDown
- Preview: in normal mode `:MarkDownPreview`

#### C++ (Makefile Project)
- Use clang instead of gcc/g++. Eg. for `ORCA`, do the following in FLAGS:
```
...
CXX = clang++ -g -stdlib=libc++ -std=c++11 -Wall
CC  = clang -g -Wall
...
LINALG_LIB = -Lorca_tools -lopenblas -L/usr/lib/gcc/x86_64-linux-gnu/11 -lgfortran
...
```
- When building the project, run `bear -- <build commands>` to generate the
`compile_commands.json` for clangd to gather compilation information. E.g. to build
`ORCA`, run:
```
bear -- make allobj -j14 && bear -- make lib && bear -- make all -j14
```


## TODO:
- [ ] Configure MarkDownPreview: https://github.com/iamcco/markdown-preview.nvim
- [ ] Configure LaTex pdf-texfile navigation
