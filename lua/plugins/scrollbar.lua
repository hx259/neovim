-- scroll bar (position indicator) for vim
return {
	{
		"petertriho/nvim-scrollbar",
		config = function()
			local colors = require("tokyonight.colors").setup()
			local gitsign = require("gitsigns")
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
			require("scrollbar").setup({
				show = true,
				show_inactivity_only = false,
				set_highlights = true,
				max_lines = false,
				hide_if_all_visible = false,
				handle = {
					color = colors.bg_highlight,
					text = " ",
					blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
					-- color_nr = nil, -- cterm
					highlight = "CursorColumn",
					hide_if_all_visible = false, -- Hides handle if all lines are visible
				},
				marks = {
					Cursor = { priority = 0, text = "❚" },
					Search = { priority = 1, color = colors.orange },
					Error = { priority = 2, color = colors.error },
					Warn = { priority = 3, color = colors.warning },
					Info = { priority = 4, color = colors.info },
					Hint = { priority = 4, color = colors.hint },
					Misc = { priority = 5, color = colors.purple },
					GitAdd = {
						priority = 6,
						text = "+",
						color = colors.green,
						highlight = "GitSignsAdd",
					},
					GitChange = {
						priority = 6,
						text = "*",
						color = colors.blue,
						highlight = "GitSignsChange",
					},
					GitDelete = {
						priority = 6,
						text = "✗",
						color = colors.red,
						highlight = "GitSignsDetele",
					},
				},
				handlers = {
					cursor = true,
					diagnostic = true,
					gitsigns = true, -- Requires gitsigns
					handle = true,
				},
			})
		end,
	},
}
