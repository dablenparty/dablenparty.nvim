return {
  'folke/trouble.nvim',
  opts = {},
  cmd = { 'Trouble' },
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = '[S]ymbols (Trouble)',
    },
    {
      '<leader>xl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = '[L]SP Definitions/References/etc. (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = '[L]ocation List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[Q]uickfix List (Trouble)',
    },
    {
      '[[',
      function()
        if require('trouble').is_open() then
          require('trouble').prev { skip_groups = true, jump = true }
          vim.diagnostic.open_float()
        elseif vim.diagnostic.is_enabled() and vim.diagnostic.get_prev() ~= nil then
          vim.diagnostic.goto_prev { float = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if ok then
            return
          end
          -- wrap to end on "no more items" error
          if string.find(err, 'E553') then
            vim.cmd [[clast]]
          else
            vim.notify(err, vim.log.levels.WARN)
          end
        end
      end,
      desc = 'Previous Trouble/[Q]uickfix Item',
    },
    {
      ']]',
      function()
        if require('trouble').is_open() then
          require('trouble').next { skip_groups = true, jump = true }
          vim.diagnostic.open_float()
        elseif vim.diagnostic.is_enabled() and vim.diagnostic.get_next() ~= nil then
          vim.diagnostic.goto_next { float = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if ok then
            return
          end
          -- wrap to start on "no more items" error
          if string.find(err, 'E553') then
            vim.cmd [[cfirst]]
          else
            vim.notify(err, vim.log.levels.WARN)
          end
        end
      end,
      desc = 'Next Trouble/[Q]uickfix Item',
    },
  },
}
