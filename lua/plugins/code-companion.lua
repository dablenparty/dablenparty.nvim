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
              local url = os.getenv 'OLLAMA_URL'
              if url == nil then
                vim.notify('Environment variable "OLLAMA_URL" not set, codecompanion will not work', vim.log.levels.ERROR, { title = 'codecompanion' })
              end
              return url
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
  end,
}
