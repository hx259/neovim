return {
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({
                enabled = true, -- start auto-save when the plugin is loaded
                execution_message = {
                    message = function() -- message to print on auto-save
                        return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                    end,
                    dim = 0.18, -- dim the message
                    cleaning_interval = 1250, -- message cleaning interval (in milliseconds)
                },
                trigger_events = {"InsertLeave", "TextChanged", "CursorHold", "CursorHoldI", "FocusLost", "BufWritePre", "BufLeave", "BufEnter"}, -- events that trigger auto-save
                condition = function(buf)
                    local fn = vim.fn
                    local is_empty = fn.empty(fn.glob(fn.expand("%:p"))) == 1
                    return not is_empty
                end,
                write_all_buffers = true, -- write all buffers
                debounce_delay = 135, -- debounce delay (in milliseconds)
            })
        end,
    },
}

