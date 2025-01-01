return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false, -- this plugin handles laziness itself
  config = function()
    local group = vim.api.nvim_create_augroup('rustaceanvim-lsp-attach', { clear = true })
    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      pattern = { '*.rs', 'Cargo.toml' },
      group = group,
      callback = function(_)
        local cur_bufnr = vim.api.nvim_get_current_buf()
        vim.keymap.set('n', '<leader>ca', function()
          vim.cmd.RustLsp 'codeAction'
        end, { desc = '[C]ode [A]ction', silent = true, buffer = cur_bufnr })
        vim.keymap.set('n', 'K', function()
          vim.cmd.RustLsp { 'hover', 'actions' }
        end, { desc = 'Hover Menu', silent = true, buffer = cur_bufnr })
      end,
    })
  end,
}
