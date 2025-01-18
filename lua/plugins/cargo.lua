return {
  'nwiizo/cargo.nvim',
  build = 'cargo build --release',
  opts = {
    float_window = true,
    window_width = 0.8,
    window_height = 0.8,
    border = 'rounded',
    auto_close = true,
    close_timeout = 5000,
  },
  ft = { 'rust' },
  cmd = {
    'CargoBench',
    'CargoBuild',
    'CargoClean',
    'CargoDoc',
    'CargoNew',
    'CargoRun',
    'CargoTest',
    'CargoUpdate',
  },
}
