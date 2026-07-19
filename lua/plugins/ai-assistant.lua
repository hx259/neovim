-- ai-assistant.lua
-- AI coding assistant via GWDG SAIA (OpenAI-compatible endpoint)
-- Requires: Neovim 0.11+, codecompanion.nvim v19+
--
-- Prerequisites:
--   export SAIA_API_KEY="your-gwdg-saia-api-key-here"
--
-- Quick reference:
--   <leader>aa  Toggle chat        <leader>ar  Chat with reasoning model
--   <leader>ai  Inline assistant   <leader>al  Chat with large model
--   <leader>ap  Action palette     <leader>am  Switch adapter (in chat)
--   ga          Add selection to chat (visual mode)

-----------------------------------------------------------------------
-- Request counter (persists across chats within one neovim session)
-----------------------------------------------------------------------
_G.saia_request_count = _G.saia_request_count or 0

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          -- Hide all built-in presets (copilot, openai, gemini, etc.)
          -- Only your three GWDG adapters will appear in the picker
          opts = {
            show_presets = false,
          },

          ---------------------------------------------------------------
          -- GWDG Coder: fast model for everyday coding tasks
          ---------------------------------------------------------------
          gwdg_coder = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "GWDG Coder",
              env = {
                url = "https://chat-ai.academiccloud.de",
                api_key = "SAIA_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "qwen3-coder-30b-a3b-instruct",
                  choices = {
                    "qwen3-coder-30b-a3b-instruct",
                    "devstral-2-123b-instruct-2512",
                    "qwen3-30b-a3b-instruct-2507",
                    "llama-3.3-70b-instruct",
                    "glm-4.7",
                  },
                },
                temperature = { default = 0.2 },
              },
            })
          end,
          ---------------------------------------------------------------
          -- GWDG Reason: thinking model for complex analysis
          ---------------------------------------------------------------
          gwdg_reason = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "GWDG Reason",
              env = {
                url = "https://chat-ai.academiccloud.de",
                api_key = "SAIA_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "qwen3-235b-a22b",
                  choices = {
                    "qwen3-235b-a22b",
                    "deepseek-r1-distill-llama-70b",
                    "qwen3-30b-a3b-thinking-2507",
                  },
                },
                temperature = { default = 0.6 },
              },
            })
          end,
          ---------------------------------------------------------------
          -- GWDG Large: heavyweight for complex multi-file work
          ---------------------------------------------------------------
          gwdg_large = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "GWDG Large",
              env = {
                url = "https://chat-ai.academiccloud.de",
                api_key = "SAIA_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "mistral-large-3-675b-instruct-2512",
                  choices = {
                    "mistral-large-3-675b-instruct-2512",
                    "openai-gpt-oss-120b",
                  },
                },
                temperature = { default = 0.1 },
              },
            })
          end,
        },
      },

      interactions = {
        chat = {
          adapter = "gwdg_coder",

          -- Custom role names shown in the chat header
          roles = {
            llm = function(adapter)
              return adapter.formatted_name or "AI"
            end,
            user = "H. Xu",
          },

          keymaps = {
            -- Remap adapter/model switching to <leader>am
            change_adapter = {
              modes = { n = "<leader>am" },
              description = "Change adapter/model",
            },
          },

          opts = {
            show_token_count = true,
          },
        },

        inline = {
          adapter = "gwdg_coder",
        },

        cmd = {
          adapter = "gwdg_coder",
        },
      },

      display = {
        chat = {
          -- Show a horizontal rule between messages
          show_header_separator = true,

          window = {
            layout = "vertical",
            width = 0.45,
            opts = {
              -- Everforest theme for the chat panel
              winhighlight = table.concat({
                "Normal:CCNormal",
                "FloatBorder:CCBorder",
                "CursorLine:CCCursorLine",
                "LineNr:CCLineNr",
                "SignColumn:CCSignColumn",
                "EndOfBuffer:CCEndOfBuffer",
                "StatusLine:CCStatusLine",
                "StatusLineNC:CCStatusLineNC",
                "Visual:CCVisual",
                "Search:CCSearch",
                -- Markdown
                "Title:CCTitle",
                "@markup.heading.1.markdown:CCH1",
                "@markup.heading.2.markdown:CCH2",
                "@markup.heading.3.markdown:CCH3",
                "@markup.strong:CCBold",
                "@markup.italic:CCItalic",
                "@markup.raw:CCCode",
                "@markup.link:CCLink",
                "@markup.list:CCListMarker",
                -- Code in fenced blocks
                "@keyword:CCKeyword",
                "@string:CCString",
                "@function:CCFunction",
                "@comment:CCComment",
                "@type:CCType",
                "@number:CCNumber",
                "@operator:CCOperator",
                "@variable:CCVariable",
              }, ","),
            },
          },
          intro_message = "GWDG AI Assistant — press ? for keymaps",
        },
        action_palette = {
          provider = "telescope",
        },
      },

      opts = {
        log_level = "ERROR",
      },
    })

    -----------------------------------------------------------------------
    -- Request counter: increments on every API response
    -- Shown in lualine (see note below) and accessible via :SaiaUsage
    -----------------------------------------------------------------------
    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionRequestFinished",
      callback = function()
        _G.saia_request_count = _G.saia_request_count + 1
      end,
    })

    -- Command to check current usage
    vim.api.nvim_create_user_command("SaiaUsage", function()
      local count = _G.saia_request_count
      vim.notify(string.format(
        "SAIA requests this session: %d\n" ..
        "Limits: 1,000/min · 10,000/hr · 50,000/day",
        count
      ), vim.log.levels.INFO, { title = "GWDG SAIA Usage" })
    end, { desc = "Show SAIA API request count" })

    -----------------------------------------------------------------------
    -- Chat panel theme: everforest colors
    --
    -- Everforest dark palette:
    --   bg0=#2b3339  bg1=#323c41  bg2=#3a454a  fg=#d3c6aa  grey=#859289
    --   red=#e67e80  orange=#e69875  yellow=#dbbc7f
    --   green=#a7c080  aqua=#83c092  blue=#7fbbb3  purple=#d699b6
    -----------------------------------------------------------------------
    local function setup_chat_highlights()
      local bg   = 0x2b3339
      local bg1  = 0x323c41
      local bg2  = 0x3a454a
      local fg   = 0xd3c6aa
      local grey = 0x859289

      local red    = 0xe67e80
      local orange = 0xe69875
      local yellow = 0xdbbc7f
      local green  = 0xa7c080
      local aqua   = 0x83c092
      local blue   = 0x7fbbb3
      local purple = 0xd699b6

      -- Base
      vim.api.nvim_set_hl(0, "CCNormal",       { bg = bg, fg = fg })
      vim.api.nvim_set_hl(0, "CCBorder",       { bg = bg, fg = bg2 })
      vim.api.nvim_set_hl(0, "CCCursorLine",   { bg = bg1 })
      vim.api.nvim_set_hl(0, "CCLineNr",       { bg = bg, fg = grey })
      vim.api.nvim_set_hl(0, "CCSignColumn",   { bg = bg })
      vim.api.nvim_set_hl(0, "CCEndOfBuffer",  { bg = bg, fg = bg })
      vim.api.nvim_set_hl(0, "CCStatusLine",   { bg = bg1, fg = fg })
      vim.api.nvim_set_hl(0, "CCStatusLineNC", { bg = bg, fg = grey })

      -- Markdown
      vim.api.nvim_set_hl(0, "CCTitle",        { bg = bg, fg = green, bold = true })
      vim.api.nvim_set_hl(0, "CCH1",           { bg = bg, fg = red, bold = true })
      vim.api.nvim_set_hl(0, "CCH2",           { bg = bg, fg = orange, bold = true })
      vim.api.nvim_set_hl(0, "CCH3",           { bg = bg, fg = yellow, bold = true })
      vim.api.nvim_set_hl(0, "CCBold",         { bg = bg, fg = fg, bold = true })
      vim.api.nvim_set_hl(0, "CCItalic",       { bg = bg, fg = fg, italic = true })
      vim.api.nvim_set_hl(0, "CCCode",         { bg = bg1, fg = aqua })
      vim.api.nvim_set_hl(0, "CCCodeBlock",    { bg = bg1 })
      vim.api.nvim_set_hl(0, "CCLink",         { bg = bg, fg = blue, underline = true })
      vim.api.nvim_set_hl(0, "CCListMarker",   { bg = bg, fg = orange })

      -- Syntax in fenced code blocks
      vim.api.nvim_set_hl(0, "CCKeyword",      { bg = bg, fg = red })
      vim.api.nvim_set_hl(0, "CCString",       { bg = bg, fg = green })
      vim.api.nvim_set_hl(0, "CCFunction",     { bg = bg, fg = aqua })
      vim.api.nvim_set_hl(0, "CCComment",      { bg = bg, fg = grey, italic = true })
      vim.api.nvim_set_hl(0, "CCType",         { bg = bg, fg = yellow })
      vim.api.nvim_set_hl(0, "CCNumber",       { bg = bg, fg = purple })
      vim.api.nvim_set_hl(0, "CCOperator",     { bg = bg, fg = orange })
      vim.api.nvim_set_hl(0, "CCVariable",     { bg = bg, fg = fg })

      -- Selection/search
      vim.api.nvim_set_hl(0, "CCVisual",       { bg = bg2 })
      vim.api.nvim_set_hl(0, "CCSearch",       { bg = yellow, fg = bg })

      -- Chat-specific: header separators and role labels
      vim.api.nvim_set_hl(0, "CodeCompanionChatSeparator", { fg = bg2 })
      vim.api.nvim_set_hl(0, "CodeCompanionChatHeader",    { fg = green, bold = true })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("CodeCompanionHighlights", { clear = true }),
      callback = setup_chat_highlights,
    })
    setup_chat_highlights()

    -----------------------------------------------------------------------
    -- Global keymaps — all under <leader>a*
    -----------------------------------------------------------------------

    vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>",
      { desc = "AI: Toggle chat" })

    vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<CR>",
      { desc = "AI: Inline assistant" })

    vim.keymap.set({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<CR>",
      { desc = "AI: Action palette" })

    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<CR>",
      { desc = "AI: Add selection to chat" })

    vim.keymap.set("n", "<leader>ar", function()
      vim.cmd("CodeCompanionChat adapter=gwdg_reason")
    end, { desc = "AI: Chat with reasoning model" })

    vim.keymap.set("n", "<leader>al", function()
      vim.cmd("CodeCompanionChat adapter=gwdg_large")
    end, { desc = "AI: Chat with large model" })

    -- Expand 'cc' into 'CodeCompanion' in command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
