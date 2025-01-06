return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  ft = { 'codecompanion', 'markdown', 'quarto' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = { render_modes = { 'n', 'c', 't' } },
  config = function(_, opts)
    require('render-markdown').setup(opts)
    Snacks.toggle({
      name = 'Render Markdown',
      get = function()
        return require('render-markdown.state').enabled
      end,
      set = function(enabled)
        local m = require 'render-markdown'
        if enabled then
          m.enable()
        else
          m.disable()
        end
      end,
    }):map '<leader>um'
  end,
}
