return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },

  build = 'cargo +nightly build --release',

  event = 'InsertEnter',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    snippets = {
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction)
        require('luasnip').jump(direction)
      end,
    },
    sources = {
      default = { 'lsp', 'path', 'luasnip', 'buffer', 'dadbod' },
    },
  },
  providers = {
    dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.default' },
}
