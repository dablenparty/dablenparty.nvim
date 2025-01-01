local win_state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local scale_factor = 0.8
  local width = opts.width or math.floor(vim.o.columns * scale_factor)
  local height = opts.height or math.floor(vim.o.lines * scale_factor)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Get the buffer or create a new one
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
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
  local window = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = window }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(win_state.floating.win) then
    win_state.floating = create_floating_window { buf = win_state.floating.buf }
    if vim.bo[win_state.floating.buf].buftype ~= 'terminal' then
      vim.cmd [[terminal]]
    end
    vim.schedule(function()
      vim.cmd [[startinsert]]
    end)
  else
    vim.api.nvim_win_hide(win_state.floating.win)
  end
end

vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<localleader>tt', toggle_terminal, { desc = '[T]oggle Floa[t]erminal' })
