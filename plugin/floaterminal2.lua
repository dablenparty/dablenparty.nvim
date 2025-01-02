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
