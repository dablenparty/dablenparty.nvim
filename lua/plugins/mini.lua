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
    'echasnovski/mini.files',
    lazy = false,
    dependencies = { 'echasnovski/mini.icons' },
    keys = {
      {
        '-',
        function()
          local mini_files = require 'mini.files'
          if not mini_files.close() then
            mini_files.open()
          end
        end,
      },
    },
    opts = {},
    config = function(_, opts)
      opts = opts or {}
      -- Do not use the MiniFiles global, it's sometimes nil
      local mini_files = require 'mini.files'
      local mini_files_augroup = vim.api.nvim_create_augroup('mini-files-keymaps', { clear = false })

      -- Set focused directory as current working directory.
      -- This isn't the entry under the cursor, but the directory
      -- that the cursor is currently inside of.
      local set_cwd = function()
        local path = (mini_files.get_fs_entry() or {}).path
        if path == nil then
          return vim.notify('Cursor is not on valid entry', vim.log.levels.WARN)
        end
        local dirname = vim.fs.dirname(path)
        vim.fn.chdir(dirname)
        vim.notify('Changed CWD to ' .. dirname)
      end

      -- Yank the full (absolute) path of the entry under the cursor
      local yank_path = function()
        local fs_entry = mini_files.get_fs_entry() or {}
        local path = fs_entry.path
        if path == nil then
          return vim.notify('Cursor is not on valid entry', vim.log.levels.WARN)
        end
        vim.fn.setreg(vim.v.register, path)
        vim.notify(string.format('Yanked path for "%s"', fs_entry.name))
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        group = mini_files_augroup,
        callback = function(event)
          local bufnr = event.data.buf_id
          vim.keymap.set('n', '`', set_cwd, { buffer = bufnr, desc = 'Set cwd' })
          vim.keymap.set('n', 'yp', yank_path, { buffer = bufnr, desc = 'Yank absolute path' })
        end,
      })

      -- Open files in splits
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local cur_target = mini_files.get_explorer_state().target_window
          local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. ' split')
            return vim.api.nvim_get_current_win()
          end)

          mini_files.set_target_window(new_target)
          mini_files.go_in()
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        group = mini_files_augroup,
        callback = function(event)
          local bufnr = event.data.buf_id
          -- Tweak keys to your liking
          map_split(bufnr, '<C-s>', 'belowright horizontal')
          map_split(bufnr, '<C-v>', 'belowright vertical')
        end,
      })

      -- use Snacks for LSP rename
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesActionRename',
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
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
  -- Highlights trailing whitespace.
  -- Some LSP's (like luals) handle this already.
  { 'echasnovski/mini.trailspace', opts = {} },
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
