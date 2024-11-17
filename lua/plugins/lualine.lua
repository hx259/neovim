  return {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup({
        options = {
          -- theme = 'everforest'
          theme = 'tokyonight'
        }
      })
    end
  }
