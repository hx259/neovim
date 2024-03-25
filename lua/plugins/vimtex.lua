return {
	"lervag/vimtex",
	ft = "tex",
	config = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_engine = "lualatex"
		vim.g.maplocalleader = " "
		vim.g.tex_flavor = "latex"
	end,
}
