return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    default_integrations = false,
    integrations = {
      blink = true,
      mason = true,
      treesitter = true,
      mini = { enabled = true, indentscope_color = 'lavender' },
    },
  },
}
