return {
  {
    'echasnovski/mini.ai',
    version = '*',
    opts = {
      n_lines = 500,
    },
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {},
  },
  {
    'echasnovski/mini.statusline',
    version = '*',
    opts = {
      use_icons = vim.g.have_nerd_font,
    },
    config = function()
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      require('mini.statusline').section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
