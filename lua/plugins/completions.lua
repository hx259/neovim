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

        -- FIX: auto-cleanup stale snippets
        -- When cursor moves outside a snippet's region, deactivate it.
        -- This prevents Tab from jumping back to old placeholders you've
        -- already left (e.g. after undo, manual cursor movement, etc.)
        region_check_events = "CursorMoved,CursorMovedI",

        -- When snippet text is deleted or changed externally (e.g. via
        -- undo or paste), clean up the snippet session.
        delete_check_events = "TextChanged,InsertLeave",
      })

      -- Load only user-defined snippets
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
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

      -- FIX: jump over ALL closing delimiters, not just ")"
      -- The original only handled ")". This caused Tab to trigger
      -- cmp.complete() when stuck between {} [] <> "" '' ``
      local closing_chars = { ")", "}", "]", ">", '"', "'", "`", "$" }
      local closing_set = {}
      for _, ch in ipairs(closing_chars) do
        closing_set[ch] = true
      end

      local jump_over_closing = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local current_line = vim.api.nvim_get_current_line()
        if col < #current_line then
          local next_char = current_line:sub(col + 1, col + 1)
          if closing_set[next_char] then
            vim.api.nvim_win_set_cursor(0, { line, col + 1 })
            return true
          end
        end
        return false
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

          -- ============================================================
          -- Tab: the fixed priority chain
          --
          -- 1. If cmp menu is visible        → cycle to next item
          -- 2. If inside an active snippet    → jump to next placeholder
          -- 3. If next char is a closing char → hop over it
          -- 4. If there's text before cursor  → trigger completion
          -- 5. Otherwise                      → insert a literal Tab
          --
          -- KEY FIX: using locally_jumpable(1) instead of
          -- expand_or_jumpable(). The old function checked BOTH "can I
          -- expand a trigger?" and "can I jump?". This caused:
          --   - \dd → \\dd  (re-expanding the "dd" trigger inside \dd)
          --   - jumping to stale snippet placeholders from old sessions
          --
          -- locally_jumpable(1) ONLY checks for jumpable nodes within
          -- the snippet region the cursor is currently inside. It never
          -- attempts to expand triggers. Expansion only happens via cmp
          -- confirm (<Enter>) or autosnippets.
          -- ============================================================
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            elseif jump_over_closing() then
              return
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- S-Tab: mirror of Tab, in reverse
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
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
