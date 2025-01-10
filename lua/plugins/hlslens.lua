return {
  'kevinhwang91/nvim-hlslens',
  event = 'BufRead',
  config = function()
    require('hlslens').setup {
      calm_down = true,
      nearest_float_when = 'always',
    }

    -- run `:nohlsearch` and export results to quickfix
    vim.keymap.set({ 'n', 'x' }, '<Leader>L', function()
      vim.schedule(function()
        if require('hlslens').exportLastSearchToQuickfix() then
          vim.cmd 'cw'
        end
      end)
      return ':noh<CR>'
    end, { desc = 'Send [l]ast search to Quickfix', expr = true })

    ---@param lhs string
    ---@param rhs string
    ---@param opts vim.api.keyset.keymap?
    local set_key = function(lhs, rhs, opts)
      opts = opts or {}
      local default_opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', lhs, rhs, vim.tbl_extend('force', default_opts, opts))
    end

    set_key('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { desc = 'Goto next search result' })
    set_key('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { desc = 'Goto previous search result' })
    set_key('*', [[*<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Search forward for nearest word' })
    set_key('#', [[#<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Search backwrad for the nearest word' })
    set_key('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Goto next occurence of nearest word' })
    set_key('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Goto previous occurence of nearest word' })
    set_key('<Leader>l', '<Cmd>noh<CR>', { desc = 'Disable search highlights' })
  end,
}
