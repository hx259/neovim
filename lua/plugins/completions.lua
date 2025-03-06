return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      -- "rafamadriz/friendly-snippets", -- Commented out for now
    },
    config = function()
      local luasnip = require("luasnip")

      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- Load only user-defined snippets
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

      -- Uncomment the lines below to enable friendly-snippets
      -- require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_vscode").lazy_load({
      --     paths = vim.fn.stdpath("data") .. "/site/pack/packer/start/friendly-snippets",
      --     exclude = { "tex" },
      -- })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local unpack = table.unpack or unpack

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local jump_over_bracket = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local current_line = vim.api.nvim_get_current_line()
        if col < #current_line and current_line:sub(col + 1, col + 1) == ")" then
          vim.api.nvim_win_set_cursor(0, { line, col + 1 })
          return true
        end
        return false
      end

      local is_unvisited_placeholder = function(node)
      -- Return true if the node is active and has not been visited before
      return node and not node.visited
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<A-q>"] = cmp.mapping.abort(),
          ["<Enter>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              -- local snippet_active = luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
              -- if is_unvisited_placeholder(snippet_active) then
                 luasnip.expand_or_jump()
              -- else
              --   fallback()
              -- end
            elseif jump_over_bracket() then
              -- Jump over the closing bracket and do nothing else
              return
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              local snippet_active = luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
              if is_unvisited_placeholder(snippet_active) then
                luasnip.jump(-1)
              else
                fallback()
              end
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find("^_+")
              local _, entry2_under = entry2.completion_item.label:find("^_+")
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },
}
