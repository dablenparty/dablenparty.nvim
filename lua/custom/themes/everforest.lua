return {
  'neanias/everforest-nvim',
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  init = function()
    local everforest = require 'everforest'
    everforest.setup()
    everforest.load()
  end,
}