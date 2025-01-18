-- Using a higher value for n_lines helps catch multi-line text objects easier
local n_lines = 500

return {
  {
    -- Better [a]round and [i]nside text objects
    -- Main textobject prefixes
    -- around = 'a',
    -- inside = 'i',
    --
    -- Next/last variants
    -- around_next = 'an',
    -- inside_next = 'in',
    -- around_last = 'al',
    -- inside_last = 'il',
    --
    -- Move cursor to corresponding edge of `a` textobject
    -- goto_left = 'g[',
    -- goto_right = 'g]',
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = {
      n_lines = n_lines,
    },
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = true },
      mappings = {
        ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },
        ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },
      },
    },
  },
  {
    -- Better [s]urround actions
    -- add = 'sa', -- Add surrounding in Normal and Visual modes
    -- delete = 'sd', -- Delete surrounding
    -- find = 'sf', -- Find surrounding (to the right)
    -- find_left = 'sF', -- Find surrounding (to the left)
    -- highlight = 'sh', -- Highlight surrounding
    -- replace = 'sr', -- Replace surrounding
    -- update_n_lines = 'sn', -- Update `n_lines`
    --
    -- suffix_last = 'l', -- Suffix to search with "prev" method
    -- suffix_next = 'n', -- Suffix to search with "next" method
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      n_lines = n_lines,
      respect_selection_type = true,
      search_method = 'cover_or_nearest',
    },
  },
  {
    'echasnovski/mini.statusline',
    opts = {
      use_icons = vim.g.have_nerd_font,
    },
    config = function(_, opts)
      opts = opts or {}
      require('mini.statusline').setup(opts)

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      require('mini.statusline').section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
