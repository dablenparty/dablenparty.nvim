return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    {
      'ellisonleao/dotenv.nvim',
      opts = {
        -- load when loading a buffer
        enable_on_load = true,
      },
    },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    vim.g.codecompanion_adapter = 'ollama'
    require('codecompanion').setup {
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
                local url = os.getenv 'OLLAMA_URL'
                if url == nil then
                  vim.notify('OLLAMA_URL is not set, codecompanion will not work', vim.log.levels.WARN)
                else
                  return url
                end
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
      opts = {
        -- I host it locally
        allow_insecure = true,
      },
    }
  end,
}
