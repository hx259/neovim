-- treesitter: for syntax highlight and indentation
--             use :TSUpdate to update parsers
--             select and "=" for indentation
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ensure_installed = {
				"lua",
				"c",
				"cpp",
				"vim",
				"latex",
				"markdown",
				"markdown_inline",
				"python",
				"ocaml",
				"ocaml_interface",
			},
			highlight = {
				enable = true,
				disable = { "latex" },
				additional_vim_regex_highlighting = { "latex", "markdown" },
			},
			indent = { enable = true },
		})
	end,
}
