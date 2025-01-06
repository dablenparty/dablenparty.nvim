return {
  'sainnhe/everforest',
  priority = 1000,
  config = function()
    -- This theme is designed to be a native Vim plugin and uses Vim globals.
    -- I designed this config function to make it "feel" more like a lazy.vim plugin.

    -- add config here, without the "everforest_" prefix
    local opts = {
      enable_italic = true,
      background = 'hard',
      -- TODO: see if this still blurs on macOS and use it if it does
      -- transparent_background = 1,
      float_style = 'dim',
      diagnostic_text_highlight = 1,
      diagnostic_virtual_text = 'highlight',
    }

    -- apply globals
    for k, v in pairs(opts) do
      local gkey = string.format('everforest_%s', k)
      vim.g[gkey] = v
    end
  end,
}
