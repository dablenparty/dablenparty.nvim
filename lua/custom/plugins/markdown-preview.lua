return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install',
  init = function()
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  config = function()
    vim.keymap.set('n', '<leader>mp', function()
      vim.cmd 'MarkdownPreview'
    end, { desc = '[M]arkdown [P]review' })
    vim.keymap.set('n', '<leader>ms', function()
      vim.cmd 'MarkdownPreviewStop'
    end, { desc = '[M]arkdown [S]top Preview' })
  end,
  ft = { 'markdown' },
}
