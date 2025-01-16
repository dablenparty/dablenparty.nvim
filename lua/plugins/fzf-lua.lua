return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  -- wait until a key is pressed or the LSP attaches to load
  lazy = true,
  event = 'LspAttach',
  keys = {
    {
      '<leader>sc',
      function()
        require('fzf-lua').colorschemes()
      end,
      desc = '[S]earch [C]olorschemes',
      mode = 'n',
    },
    {
      '<leader>sh',
      function()
        require('fzf-lua').helptags()
      end,
      desc = '[S]earch [H]elp',
      mode = 'n',
    },
    {
      '<leader>sk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = '[S]earch [K]eymaps',
      mode = 'n',
    },
    {
      '<leader>sf',
      function()
        require('fzf-lua').files()
      end,
      desc = '[S]earch [F]iles',
      mode = 'n',
    },
    {
      '<leader>sw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = '[S]earch current [W]ord',
      mode = 'n',
    },
    {
      '<leader>sg',
      function()
        require('fzf-lua').grep()
      end,
      desc = '[S]earch by [G]rep',
      mode = 'n',
    },
    {
      '<leader>sl',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = '[S]earch by [L]ive Grep',
    },
    {
      '<leader>sd',
      function()
        require('fzf-lua').diagnostics_workspace()
      end,
      desc = '[S]earch [D]iagnostics',
      mode = 'n',
    },
    {
      '<leader>sr',
      function()
        require('fzf-lua').resume()
      end,
      desc = '[S]earch [R]esume',
      mode = 'n',
    },
    {
      '<leader><leader>',
      function()
        require('fzf-lua').buffers()
      end,
      desc = '[ ] Find existing buffers',
      mode = 'n',
    },
  },
  opts = {},
}
