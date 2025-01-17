return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false, -- this plugin handles laziness itself
  config = function()
    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      pattern = { '*.rs', 'Cargo.toml' },
      group = vim.api.nvim_create_augroup('rustaceanvim-lsp-attach', { clear = true }),
      callback = function(event)
        ---@param lhs string
        ---@param rhs string
        ---@param opts vim.api.keyset.keymap?
        local set_key = function(lhs, rhs, opts)
          opts = opts or {}
          local default_opts = { buffer = event.buf, silent = true }

          vim.api.nvim_set_keymap('n', lhs, rhs, vim.tbl_deep_extend('force', default_opts, opts))
        end

        set_key('<leader>ca', '<cmd>RustLsp codeAction<CR>', { desc = '[C]ode [A]ction' })
        set_key('K', '<cmd>RustLsp hover actions', { desc = 'Hover Menu' })
      end,
    })
  end,
}
