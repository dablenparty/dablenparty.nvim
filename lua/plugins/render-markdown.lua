return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  -- make sure to include injected languages here too
  ft = { 'codecompanion', 'markdown', 'quarto', 'rust' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    render_modes = { 'n', 'c', 't' },
    injections = {
      rust = {
        enabled = true,
        query = [[
          ((line_comment (doc_comment) @injection.content
              (#set! injection.language "markdown")
              (#set! injection.include-children)))

          ((line_comment) @injection.content
              (#set! injection.language "markdown")
              (#set! injection.include-children))

          ((block_comment) @injection.content
              (#set! injection.language "markdown")
              (#set! injection.include-children))
        ]],
      },
    },
  },
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
