---@diagnostic disable: lowercase-global
---@alias floaterminal.FloatingWinState { buf: number, win: number }
---@alias floaterminal.State { most_recent_buf: number, floating: floaterminal.FloatingWinState }

---@type floaterminal.State
local ft_state = {
  most_recent_buf = -1,
  floating = {
    buf = -1,
    win = -1,
  },
}

---@return number buf Newly created buffer ID.
function create_new_buffer()
  return vim.api.nvim_create_buf(false, true)
end

---Creates a minimal floating window relative to the editor from the provided options.
---@param opts? { buf: number, height?: number, width?: number }
---@return floaterminal.OpenTermState state
function create_floating_window(opts)
  opts = opts or {}

  local scale_factor = 0.8
  local width = opts.width or math.floor(vim.o.columns * scale_factor)
  local height = opts.height or math.floor(vim.o.lines * scale_factor)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Get the buffer or create a new one
  local win_buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    win_buf = opts.buf
  else
    win_buf = create_new_buffer()
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  -- Create floating window
  local window = vim.api.nvim_open_win(win_buf, true, win_config)

  return { buf = win_buf, win = window }
end

function get_term_buffers()
  local all_bufs = vim.api.nvim_list_bufs()
  return vim.fn.filter(all_bufs, function(_, bufnr)
    return vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == 'terminal'
  end)
end

---Toggles the Floaterminal window, displaying the proivided buffer. If the buffer is not yet a terminal, it is
---made into one.
---@param win_buf? number Optional buffer to attach to the window. If one is not provided, a new buffer is created.
function toggle_terminal(win_buf)
  win_buf = win_buf or -1
  if not vim.api.nvim_win_is_valid(ft_state.floating.win) then
    ft_state.floating = create_floating_window { buf = win_buf }
    win_buf = ft_state.floating.buf
    ft_state.most_recent_buf = win_buf
    if vim.bo[win_buf].buftype ~= 'terminal' then
      vim.cmd [[terminal]]
    end
    vim.schedule(function()
      vim.cmd [[startinsert]]
    end)
  else
    vim.api.nvim_win_hide(ft_state.floating.win)
  end
end

---Toggles the Floaterminal window with the most recently used terminal buffer. If no buffer exists, it is
---created.
function toggle_recent_terminal()
  toggle_terminal(ft_state.most_recent_buf)
end

function toggle_from_telescope(opts)
  opts = opts or {}

  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local theme = require('telescope.themes').get_dropdown(opts)

  -- TODO: better names for terminal buffers
  local results = vim.fn.map(get_term_buffers(), function(idx, bufnr)
    return { idx = idx, bufnr = bufnr, name = vim.api.nvim_buf_get_name(bufnr) }
  end)

  -- see: https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md
  pickers
    .new(theme, {
      prompt_title = 'Ssearch Floaterminals',
      finder = finders.new_table {
        results = results,
        entry_maker = function(entry)
          return {
            value = entry,
            display = function(tbl)
              return string.format('%d: %s', tbl.value.idx, tbl.value.name)
            end,
            ordinal = entry.name,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          toggle_terminal(selection.value.bufnr)
        end)
        return true
      end,
    })
    :find()
end

vim.api.nvim_create_user_command('FloaterminalList', function(_)
  print(vim.inspect(ft_state))
end, {})
-- TODO: toggle terminal by index (create keymaps '<localleader>t{index}')

vim.keymap.set('n', '<localleader>ts', toggle_from_telescope, { desc = 'Floa[t]erminal [S]earch' })
vim.keymap.set('n', '<localleader>tt', toggle_recent_terminal, { desc = '[T]oggle Recent Floa[t]erminal' })
vim.keymap.set('n', '<localleader>tn', toggle_terminal, { desc = '[T]oggle [N]ew Floaterminal' })
