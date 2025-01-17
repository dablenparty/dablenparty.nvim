return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  -- only load this plugin inside the vault folders
  event = {
    'BufReadPre *' .. vim.fn.expand '~' .. '/obsidian/vault/*',
    'BufNewFile *' .. vim.fn.expand '~' .. '/obsidian/vault/*',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    -- ui handled by render-markdown
    ui = { enable = false },
    completion = {
      -- NOTE: https://github.com/epwalsh/obsidian.nvim/issues/770#issuecomment-2564121989
      nvim_cmp = true,
    },
    workspaces = {
      -- my default vault location
      {
        name = 'personal',
        path = '~/obsidian/vault',
        overrides = {
          notes_subdir = 'Notes',
        },
      },
    },
    preferred_link_style = 'markdown',
    templates = {
      folder = 'Templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },
  },
  -- init = function()
  --   vim.o.conceallevel = 2
  -- end,
}
