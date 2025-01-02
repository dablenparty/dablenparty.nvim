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

---@param opts? { buf: number, height?: number, width?: number }
---@return floaterminal.OpenTermState
local function create_floating_window(opts)
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
    win_buf = vim.api.nvim_create_buf(false, true)
    vim.list_extend(ft_state.ft_bufs, { win_buf })
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
