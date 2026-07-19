return {
	"lervag/vimtex",
	ft = "tex",
	config = function()
		vim.g.vimtex_view_method = "general"
		vim.g.vimtex_compiler_engine = "lualatex"
		vim.g.tex_flavor = "latex"
		vim.g["vimtex_quickfix_mode"] = 0
    vim.g['vimtex_indent_enabled'] = 1
		vim.g["vimtex_log_ignore"] = {
			"Underfull",
			"Overfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
		}
    vim.g.vimtex_compiler_latexmk = {
      out_dir = "build",
      options = {
        '-pdf',
        '-shell-escape',
        '-lualatex',
        '-interaction=nonstopmode',
        '-synctex=1',
      }
    }
	end,
}
