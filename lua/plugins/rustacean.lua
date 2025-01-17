return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false, -- this plugin handles laziness itself
  config = function()
    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      pattern = { '*.rs', 'Cargo.toml' },
      group = vim.api.nvim_create_augroup('rustaceanvim-lsp-attach', { clear = true }),
      callback = function(event)
        local set_key = function(lhs, rhs, desc)
          local opts = { buffer = event.buf, silent = true, desc = desc }

          vim.keymap.set('n', lhs, rhs, opts)
        end

        set_key('<leader>ca', '<cmd>RustLsp codeAction<CR>', '[C]ode [A]ction')
        set_key('K', '<cmd>RustLsp hover actions', 'Hover Menu')
      end,
    })
  end,
}
