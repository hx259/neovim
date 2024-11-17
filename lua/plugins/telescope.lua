-- telescope: searching through directories and files
return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		config = function()
			-- vim.keymap.set('n', '<leader>f', "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<AS-f>", builtin.find_files, {})
			vim.keymap.set("n", "<A-f>", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>F", builtin.current_buffer_fuzzy_find, {})
			-- vim.keymap.set("n", "<leader>ff", builtin.grep_string, {})
			vim.keymap.set("n", "<leader>re", builtin.resume, {})
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
			-- vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})
			vim.keymap.set("n", "<leader>rr", builtin.lsp_references, {})
      --
      require("telescope").load_extension("live_grep_args")
      local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
      vim.keymap.set("n", "<leader>ff", live_grep_args_shortcuts.grep_word_under_cursor)
      vim.keymap.set("v", "<leader>ff", live_grep_args_shortcuts.grep_visual_selection)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extension = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
