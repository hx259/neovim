# Neovim Configuration for LaTeX, Markdown and C++

A clean, modular Neovim setup managed by [Lazy.nvim](https://github.com/folke/lazy.nvim),
built around telescope navigation, nvim-cmp completion, and clangd for C++ development.

## Installation

Clone this repo into your Neovim config directory:

```bash
git clone https://github.com/hx259/neovim.git ~/.config/nvim
```

Open Neovim — Lazy will auto-install all plugins on first run.

### Prerequisites

- Neovim ≥ 0.11
- `sudo apt install texlive-full` (for LaTeX)
- `sudo apt install fzf ripgrep` (for telescope search)
- `sudo apt install clangd` or install via Mason (`:Mason`)
- `bear` (for generating `compile_commands.json` from Makefiles)

### Font

JetBrainsMono Regular size 13 from [Nerd Fonts](https://www.nerdfonts.com/):

```bash
# Download and install
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -f -v
```

---

## Keymap Reference

The **leader key** is `<Space>`.

### Navigation (Telescope)

These are the primary navigation keymaps. Most code navigation happens
through telescope grep and LSP symbol search, not through the file tree.

| Keymap          | Mode | Action                                      |
|-----------------|------|---------------------------------------------|
| `<Alt-f>`       | n    | Live grep across project (ripgrep)          |
| `<Alt-Shift-f>` | n    | Find file by name                           |
| `<Space>F`      | n    | Fuzzy search in current buffer              |
| `<Space>ff`     | n    | Grep word under cursor (project-wide)       |
| `<Space>ff`     | v    | Grep visual selection (project-wide)        |
| `<Space>b`      | n    | List and switch open buffers                |
| `<Space>re`     | n    | Resume last telescope picker                |

### Code Intelligence (LSP)

| Keymap          | Mode | Action                                      |
|-----------------|------|---------------------------------------------|
| `<Space>d`      | n    | Go to definition                            |
| `<Space>h`      | n    | Hover documentation                         |
| `<Space>rr`     | n    | List all references (telescope)             |
| `<Space>fs`     | n    | Document symbols (telescope)                |
| `<Space>ca`     | n, v | Code actions                                |
| `<Space>fm`     | n    | Format file                                 |
| `en`            | n    | Jump to next diagnostic                     |
| `EN`            | n    | Jump to previous diagnostic                 |

### Completion and Snippets

Tab is overloaded with a priority chain. In insert mode, pressing Tab does
the first matching action in this order:

1. **cmp menu visible** → cycle to next completion item
2. **inside active snippet** → jump to next placeholder
3. **cursor before a closing delimiter** `) } ] > " ' \`` → hop over it
4. **text before cursor** → trigger completion menu
5. **nothing matches** → insert a literal Tab

| Keymap          | Mode | Action                                      |
|-----------------|------|---------------------------------------------|
| `<Tab>`         | i, s | Cycle cmp / jump snippet / hop bracket      |
| `<Shift-Tab>`   | i, s | Reverse cycle cmp / jump snippet backward   |
| `<Enter>`       | i    | Confirm selected completion                 |
| `<Ctrl-Space>`  | i    | Manually trigger completion menu            |
| `<Alt-q>`       | i    | Dismiss completion menu                     |
| `<Ctrl-b/f>`    | i    | Scroll completion docs up/down              |

Custom LaTeX snippets are in `~/.config/nvim/LuaSnip/tex/`. Snippets use
short triggers: `fk` → `\frac{}{}`, `dd` → `\dd`, `ga` → `\alpha`,
`beg` → `\begin{}\end{}`, etc.

### Window and Cursor Movement

| Keymap          | Mode    | Action                                    |
|-----------------|---------|-------------------------------------------|
| `<Alt-h/j/k/l>` | n, i, v | Move between splits                      |
| `<Ctrl-j>`      | n, v    | Scroll down (viewport)                   |
| `<Ctrl-k>`      | n, v    | Scroll up (viewport)                     |
| `<Space>-`      | n       | Jump to previous position (`<Ctrl-o>`)   |
| `<Space>=`      | n       | Jump to next position (`<Ctrl-i>`)       |
| `<Ctrl-z>`      | n, i, v | Undo                                     |

### File Explorer

| Keymap            | Mode | Action                                    |
|-------------------|------|-------------------------------------------|
| `<Ctrl-n>`        | n    | Open neo-tree (filesystem, left panel)    |
| `<Ctrl-Alt-n>`    | n    | Close neo-tree                            |

### Git

| Keymap          | Mode | Action                                      |
|-----------------|------|---------------------------------------------|
| `<Space>gb`     | n    | Git blame (fugitive)                        |
| `<Space>gd`     | n    | Diff this (gitsigns)                        |
| `gn`            | n    | Next git hunk                               |
| `GN`            | n    | Previous git hunk                           |
| `gs`            | n, v | Stage hunk                                  |
| `gr`            | n, v | Reset hunk                                  |
| `gu`            | n    | Undo stage hunk                             |
| `gh`            | n    | Preview hunk                                |
| `gb`            | n    | Blame line (inline)                         |

### LaTeX (vimtex)

| Keymap          | Mode | Action                                      |
|-----------------|------|---------------------------------------------|
| `<Space>ll`     | n    | Build and continuous watch                  |
| `<Space>lv`     | n    | Open PDF viewer (zathura)                   |

### Markdown

Use `:MarkdownPreview` in normal mode to preview.

---

## C++ Development (Makefile Projects)

Use clang instead of gcc for better clangd integration. Example flags:

```makefile
CXX = clang++ -g -stdlib=libc++ -std=c++11 -Wall
CC  = clang -g -Wall
LINALG_LIB = -Lorca_tools -lopenblas -L/usr/lib/gcc/x86_64-linux-gnu/11 -lgfortran
```

Generate `compile_commands.json` for clangd using `bear`:

```bash
bear -- make allobj -j14 && bear -- make lib && bear -- make all -j14
```

This gives clangd full knowledge of include paths, flags, and definitions.

---

## Plugin List

| Plugin                     | Purpose                                       |
|----------------------------|-----------------------------------------------|
| `lazy.nvim`                | Plugin manager                                |
| `nvim-lspconfig` + `mason` | LSP (clangd, basedpyright, texlab, cmake ...) |
| `nvim-cmp`                 | Completion engine (LSP, snippets, buffer)     |
| `LuaSnip`                  | Snippet engine with custom LaTeX snippets     |
| `telescope.nvim`           | Fuzzy finder, grep, symbol search             |
| `nvim-treesitter`          | Syntax highlighting and indentation           |
| `neo-tree.nvim`            | File explorer                                 |
| `vim-fugitive`             | Git commands                                  |
| `gitsigns.nvim`            | Git hunk navigation and staging               |
| `nvim-scrollbar`           | Scrollbar with diagnostics and git markers    |
| `lualine.nvim`             | Statusline                                    |
| `conform.nvim`             | Formatting (stylua)                           |
| `auto-save.nvim`           | Automatic save on text change                 |
| `vimtex`                   | LaTeX compilation and PDF preview             |
| `tokyonight.nvim`          | Colorscheme                                   |

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point: lazy bootstrap + requires
├── lua/
│   ├── nvim-options.lua        # Vim options, keymaps, leader key
│   └── plugins/                # One file per plugin (lazy.nvim convention)
│       ├── completions.lua     # nvim-cmp + LuaSnip config
│       ├── lsp-config.lua      # LSP servers (clangd, pyright, texlab ...)
│       ├── telescope.lua       # Telescope keymaps and extensions
│       ├── treesitter.lua      # Syntax parsers
│       ├── git.lua             # fugitive + gitsigns
│       ├── neotree.lua         # File explorer
│       ├── colorschemes.lua    # tokyonight
│       ├── lualine.lua         # Statusline
│       ├── scrollbar.lua       # Scrollbar with git/diagnostic marks
│       ├── auto-save.lua       # Auto-save on text change
│       ├── none-ls.lua         # Formatting
│       ├── markdown-preview.lua
│       └── vimtex.lua          # LaTeX build + PDF viewer
└── LuaSnip/                    # Custom snippet definitions
    ├── all.lua                 # Global snippets (all filetypes)
    └── tex/                    # LaTeX-specific snippets
        ├── basic_maths.lua     # Fractions, brackets, fonts, ...
        ├── basic_physics.lua   # Bra-ket, derivatives, Wick, ...
        ├── env.lua             # Environments (equation, align, ...)
        └── greek_letters.lua   # ga→α, gb→β, gg→γ, ...
```
