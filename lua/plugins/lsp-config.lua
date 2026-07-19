-- lsp-config.lua
-- Neovim 0.11+ native LSP configuration
-- Replaces the old mason-lspconfig + nvim-lspconfig pipeline
--
-- Mason is kept solely as a convenient installer for LSP servers.
-- The actual LSP configuration uses vim.lsp.config() + vim.lsp.enable().

return {
	-- Mason: only used to install servers (not to configure them)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- Mason tool installer: auto-install your servers
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"lua-language-server",
					"clangd",
					"cmake-language-server",
					"texlab",
					"autotools-language-server",
					"marksman",
					"basedpyright",
				},
			})
		end,
	},
	-- LSP keymaps and cmp capability wiring (no nvim-lspconfig needed)
	{
		-- Dummy spec: just runs the native LSP setup after mason installs servers
		dir = vim.fn.stdpath("config"),
		name = "lsp-native-setup",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Merge cmp capabilities into every server
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			----------------------------------------------------------------
			-- Server configurations via vim.lsp.config()
			----------------------------------------------------------------
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--query-driver=/usr/bin/clang++",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				root_markers = { "compile_commands.json", ".clangd", ".git" },
			})

			vim.lsp.config("cmake", {
				capabilities = capabilities,
			})

			vim.lsp.config("texlab", {
				capabilities = capabilities,
			})

			vim.lsp.config("autotools_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("marksman", {
				capabilities = capabilities,
			})

			vim.lsp.config("basedpyright", {
				capabilities = capabilities,
			})

			----------------------------------------------------------------
			-- Enable all configured servers
			----------------------------------------------------------------
			vim.lsp.enable({
				"lua_ls",
				"clangd",
				"cmake",
				"texlab",
				"autotools_ls",
				"marksman",
				"basedpyright",
			})

			----------------------------------------------------------------
			-- Keymaps (identical to your old config)
			----------------------------------------------------------------
			vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "en", vim.diagnostic.goto_next)
			vim.keymap.set("n", "EN", vim.diagnostic.goto_prev)
		end,
	},
}
