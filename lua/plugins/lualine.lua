  return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup({
      options = {
        -- theme = 'everforest'
        theme = 'tokyonight'
      },
      sections = {
        lualine_x = {
          -- SAIA request counter: shows "SAIA: 42" when AI has been used
          {
            function()
              local count = _G.saia_request_count or 0
              if count > 0 then
                return "SAIA: " .. count
              end
              return ""
            end,
            cond = function()
              return (_G.saia_request_count or 0) > 0
            end,
            color = { fg = "#a7c080" }, -- everforest green
          },
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    })
  end,
}
