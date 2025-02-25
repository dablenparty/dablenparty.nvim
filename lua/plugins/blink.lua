return {
  {
    'saghen/blink.nvim',
    keys = {
      -- chartoggle
      {
        ';',
        function()
          require('blink.chartoggle').toggle_char_eol ';'
        end,
        mode = { 'n', 'v' },
        desc = 'Toggle ; at EOL',
      },
      {
        ',',
        function()
          require('blink.chartoggle').toggle_char_eol ','
        end,
        mode = { 'n', 'v' },
        desc = 'Toggle , at EOL',
      },
    },
    -- all modules handle lazy loading internally
    lazy = false,
    opts = {
      chartoggle = { enabled = true },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
      },
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      {
        'saghen/blink.compat',
        lazy = true,
        version = false,
      },
    },

    build = 'rustup run nightly cargo build --release',

    event = { 'InsertEnter', 'LspAttach' },
    lazy = true,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default', ['<C-e>'] = { 'hide', 'fallback' } },

      appearance = {
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      snippets = { preset = 'luasnip' },
      sources = {
        default = function()
          local default_sources = { 'lsp', 'path', 'snippets', 'buffer' }

          -- Remove LSP sources when editing comments.
          -- Since some langauges have multiple comment types (and "comment_content" is its own node),
          -- simply checking if the node type has the word "comment" works better for me.
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and node:type():find 'comment' then
            default_sources = { 'path', 'snippets', 'buffer' }
          end

          -- effectively a set, see: https://www.lua.org/pil/11.5.html
          local source_to_ft = {
            dadbod = { sql = true, mysql = true, plsql = true },
            codecompanion = { codecompanion = true },
            lazydev = { lua = true },
            obsidian = { markdown = true },
            obsidian_new = { markdown = true },
            obsidian_tags = { markdown = true },
          }

          local sources = default_sources
          for src, fts in pairs(source_to_ft) do
            if fts[vim.bo.filetype] then
              vim.list_extend(sources, { src })
            end
          end

          return sources
        end,
        providers = {
          codecompanion = { name = 'CodeCompanion', module = 'codecompanion.providers.completion.blink' },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          obsidian = {
            name = 'obsidian',
            module = 'blink.compat.source',
          },
          obsidian_new = {
            name = 'obsidian_new',
            module = 'blink.compat.source',
          },
          obsidian_tags = {
            name = 'obsidian_tags',
            module = 'blink.compat.source',
          },
        },
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.default' },
  },
}
