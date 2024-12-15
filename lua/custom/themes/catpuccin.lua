return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
  opts = {
    default_integrations = false,
    integrations = {
      cmp = true,
      mason = true,
      treesitter = true,
      mini = { enabled = true, indentscope_color = 'lavender' },
    },
  },
}
