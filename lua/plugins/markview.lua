return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  opts = function(_, opts)
    opts = opts or {}
    local presets = require 'markview.presets'

    return {
      markdown = {
        headings = presets.headings.glow,
        horizontal_rules = presets.horizontal_rules.thick,
        tables = presets.tables.rounded,
      },
    }
  end,
}
