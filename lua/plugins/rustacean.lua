return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false, -- this plugin handles laziness itself
  init = function()
    ---@module 'rustaceanvim'
    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
      ---@type rustaceanvim.lsp.ClientOpts
      server = {
        on_attach = function(_, bufnr)
          local set_key = function(lhs, rhs, desc)
            local opts = { buffer = bufnr, silent = true, desc = desc }

            vim.keymap.set('n', lhs, rhs, opts)
          end

          -- overwrite LSP code actions and hover menu
          set_key('<leader>ca', '<cmd>RustLsp codeAction<CR>', '[C]ode [A]ction')
          set_key('K', '<cmd>RustLsp hover actions<CR>', 'Hover Menu')

          -- useful diagnostic binds
          set_key('<leader>xd', '<cmd>RustLsp renderDiagnostic current', 'Render [D]iagnostic')
          set_key('<leader>xD', '<cmd>RustLsp renderDiagnostic cycle', 'Render Next [D]iagnostic')
          set_key('<leader>xe', '<cmd>RustLsp explainError current', 'E[x]plain [E]rror on line')
          set_key('<leader>xE', '<cmd>RustLsp explainError cycle', 'E[x]plain Next [E]rror')
          set_key('<leader>xr', '<cmd>RustLsp relatedDiagnostics', '[R]elated Diagnostics')

          -- misc
          set_key('gx', '<cmd>RustLsp openDocs', 'Open docs.rs for the symbol under the cursor.')
        end,
      },
    }
  end,
}
