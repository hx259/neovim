-- auto-save.lua
-- Replaces Pocco81/auto-save.nvim with a simple autocommand.
-- The plugin is abandoned and crashes on invalid buffer ids when
-- temporary buffers (telescope, neo-tree, codecompanion) are closed
-- before the scheduled save callback fires.
--
-- This does the same thing: saves all writable buffers on common events,
-- with a debounce to avoid excessive writes.

-- No plugin needed — just return an empty table for lazy.nvim
return {
  {
    dir = vim.fn.stdpath("config"),
    name = "auto-save-custom",
    lazy = false,
    init = function()                          -- ← init, not config
      local timer = vim.uv.new_timer()
      local save_delay_ms = 135

      local function do_save()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf)
            and vim.api.nvim_buf_is_loaded(buf)
            and vim.bo[buf].modified
            and vim.bo[buf].buftype == ""
            and vim.api.nvim_buf_get_name(buf) ~= ""
            -- and vim.bo[buf].filetype ~= "tex"
          then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd("write")
            end)
          end
        end
      end

      local function debounced_save()
        timer:stop()
        timer:start(save_delay_ms, 0, vim.schedule_wrap(do_save))
      end

      -- (1) Periodic save every 2 minutes, regardless of activity
      local periodic = vim.uv.new_timer()
      periodic:start(120000, 120000, vim.schedule_wrap(do_save))

      -- (2) Mode changes  +  (3) buffer switches  +  other useful events
      vim.api.nvim_create_autocmd(
        { "InsertLeave",
          "ModeChanged",                       -- ← any mode transition
          "BufLeave", "FocusLost",             -- ← buffer/window switch
          "CursorHold", "CursorHoldI" },
        {
          group = vim.api.nvim_create_augroup("AutoSaveCustom", { clear = true }),
          callback = debounced_save,
        }
      )
    end,
  },
}
