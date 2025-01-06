return {
  'ellisonleao/dotenv.nvim',
  config = function()
    require('dotenv').setup { enable_on_load = false }
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('dotenv-vim-enter', { clear = true }),
      command = 'Dotenv',
    })
  end,
}
