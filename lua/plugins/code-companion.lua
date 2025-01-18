return {
  'olimorris/codecompanion.nvim',
  lazy = true,
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
  keys = {
    { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = 'n', noremap = true, silent = true },
    { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = 'v', noremap = true, silent = true },
    { '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', mode = 'n', noremap = true, silent = true },
    { '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', mode = 'v', noremap = true, silent = true },
    { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', noremap = true, silent = true, desc = 'Add to CodeCompanion' },
  },
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions', 'CodeCompanionCmd' },
  config = function(_, opts)
    opts = opts or {}
    -- sets global provider so that I don't have to manually set it for each action
    vim.g.codecompanion_adapter = 'ollama'

    require('codecompanion').setup(opts)

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
