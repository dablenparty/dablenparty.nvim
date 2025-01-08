return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    {
      'ellisonleao/dotenv.nvim',
      opts = {
        -- load when loading a buffer
        enable_on_load = false,
      },
      config = function(_, opts)
        opts = opts or {}

        require('dotenv').setup(opts)

        local env_path = vim.fn.stdpath 'config' .. '/.env'
        vim.cmd(string.format('Dotenv %s', env_path))
      end,
    },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen2.5-coder:7b',
            },
          },
          env = {
            url = function()
              return os.getenv 'OLLAMA_URL'
            end,
          },
          headers = {
            ['Content-Type'] = 'application/json',
          },
          parameters = {
            sync = true,
          },
        })
      end,
    },
    -- adapter opts
    opts = {
      -- I host it locally
      allow_insecure = true,
    },
  },
  config = function(_, opts)
    opts = opts or {}
    -- sets global provider so that I don't have to manually set it for each action
    vim.g.codecompanion_adapter = 'ollama'

    require('codecompanion').setup(opts)

    vim.api.nvim_set_keymap('n', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'Check for envvars required by codecompanion',
      group = vim.api.nvim_create_augroup('codecompanion-vim-enter', { clear = true }),
      once = true,
      callback = function(_)
        local url = os.getenv 'OLLAMA_URL'
        if url == nil then
          vim.schedule(function()
            vim.notify('OLLAMA_URL not set in neovim config, codecompanion will not work', vim.log.levels.WARN, { title = 'Missing Environment Variable' })
          end)
        end
      end,
    })
  end,
}
