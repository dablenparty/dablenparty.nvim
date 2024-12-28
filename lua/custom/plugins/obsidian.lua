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
    workspaces = {
      -- my default vault location
      {
        name = 'personal',
        path = '~/obsidian/vault',
      },
    },
  },
  init = function()
    vim.o.conceallevel = 2
  end,
}
