---@alias floaterminal.OpenTermState { buf: number, win: number }
---@alias floaterminal.State { most_recent_buf: number, all_bufs: [number], win: number }

---@type floaterminal.State
local win_state = {
  most_recent_buf = -1,
  all_bufs = {},
  win = -1,
}

---@param opts { buf: number, height?: number, width?: number }
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
