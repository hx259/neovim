-- map leader key: space!
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("filetype indent on")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.cmd("set number")
vim.cmd("set linebreak")
vim.cmd("set ignorecase")
vim.cmd("set wrap")
vim.cmd("set wrapmargin=2")
vim.cmd("set clipboard=unnamed")
vim.cmd("inoremap <c-z> <c-u>")
vim.cmd("nnoremap <c-z> u")
vim.cmd("vnoremap <c-z> u")
vim.cmd("inoremap <A-h> <c-w>h")
vim.cmd("nnoremap <A-h> <c-w>h")
vim.cmd("vnoremap <A-h> <c-w>h")
vim.cmd("inoremap <A-j> <c-w>j")
vim.cmd("nnoremap <A-j> <c-w>j")
vim.cmd("vnoremap <A-j> <c-w>j")
vim.cmd("inoremap <A-k> <c-w>k")
vim.cmd("nnoremap <A-k> <c-w>k")
vim.cmd("vnoremap <A-k> <c-w>k")
vim.cmd("inoremap <A-l> <c-w>l")
vim.cmd("nnoremap <A-l> <c-w>l")
vim.cmd("vnoremap <A-l> <c-w>l")
vim.cmd("nnoremap <c-j> <c-e>")
vim.cmd("vnoremap <c-j> <c-e>")
vim.cmd("nnoremap <c-k> <c-y>")
vim.cmd("vnoremap <c-k> <c-y>")
vim.cmd("nnoremap - <Nop>")
vim.cmd("nnoremap + <Nop>")
vim.cmd("nnoremap <leader>= <c-i>")
vim.cmd("nnoremap <leader>- <c-o>")

vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.tex_IgnoreLevel = 8

-- -- jumping through snippets
-- vim.cmd[[
-- " Use Tab to expand and jump through snippets
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
-- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
-- 
-- " Use Shift-Tab to jump backwards through snippets
-- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- ]]


-- Set global formatoptions
vim.opt.formatoptions = vim.opt.formatoptions
    - 'o'  -- Don't continue comments when pressing 'o' or 'O'
    + 'c'  -- Continue comments when pressing Enter
    + 'r'  -- Automatically insert comment leader after pressing Enter

-- -- Lua function to handle <CR> behavior and avoid extra '//' on new lines
-- function _G.check_enter()
--     local line = vim.api.nvim_get_current_line()
--     if string.match(line, "^%s*//") then
--         return vim.api.nvim_replace_termcodes('<CR>// ', true, true, true)
--     elseif string.match(line, "^%s*/%*") then
--         return vim.api.nvim_replace_termcodes('<CR>* ', true, true, true)
--     else
--         return vim.api.nvim_replace_termcodes('<CR>', true, true, true)
--     end
-- end

-- -- Handle '<CR>' (Enter) in insert mode to continue comments manually
-- vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.check_enter()', { noremap = true, expr = true })

-- Ensure 'o' and 'O' start a new line without continuing the comment, and enter insert mode
vim.api.nvim_set_keymap('n', 'o', [[o<Esc>^"_cc]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'O', [[O<Esc>^"_cc]], { noremap = true, silent = true })
