return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Add more as needed:
				cpp = { "clang-format" },
				python = { "black" },
				-- cmake = { "cmake_format" },
			},
		})
		-- Same keymap you already use
		vim.keymap.set("n", "<leader>fm", function()
			require("conform").format({ lsp_fallback = true })
		end, {})
	end,
}
