---@diagnostic disable: lowercase-global
---@alias floaterminal.FloatingWinState { buf: number, win: number }
---@alias floaterminal.State { most_recent_buf: number, ft_bufs: [number], floating: floaterminal.FloatingWinState }

---@type floaterminal.State
local ft_state = {
  most_recent_buf = -1,
  ft_bufs = {},
  floating = {
    buf = -1,
    win = -1,
  },
}

---@return number buf Newly created buffer ID.
function create_new_buffer()
  buf = vim.api.nvim_create_buf(false, true)
  vim.list_extend(ft_state.ft_bufs, { buf })
  return buf
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

vim.api.nvim_create_user_command('FloaterminalList', function(_)
  print(vim.inspect(ft_state))
end, {})
-- TODO: toggle terminal by index (create keymaps '<localleader>t{index}')
-- make functions nonlocal?
vim.keymap.set('n', '<localleader>tt', toggle_recent_terminal, { desc = '[T]oggle Recent Floa[t]erminal' })
vim.keymap.set('n', '<localleader>tn', toggle_terminal, { desc = '[T]oggle [N]ew Floaterminal' })
