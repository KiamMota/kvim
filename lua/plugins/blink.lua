vim.pack.add({
  { src = 'https://github.com/rafamadriz/friendly-snippets', opt = true }
})

-- Depois instala o plugin principal
vim.pack.add({
  { 
    src = 'https://github.com/saghen/blink.cmp', 
    opt = true,
    config = function()
      -- garante que o plugin e dependências estão carregados
      vim.cmd('packadd friendly-snippets')
      vim.cmd('packadd blink.cmp')

      -- Configuração equivalente ao opts
      require('blink.cmp').setup({
        keymap = {
          preset = 'enter',
          ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide' },
          ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        appearance = {
          nerd_font_variant = 'mono',
        },
        completion = {
          trigger = {
            show_on_insert_on_trigger_character = true,
          },
          list = {
            max_items = 200,
            selection = {
              preselect = true,
              auto_insert = false,
            },
          },
          menu = {
            border = 'single',
            min_width = 20,
            max_height = 20,
            draw = {
              columns = {
                { 'kind_icon', gap = 1 },
                { 'label', 'label_description', gap = 2 },
                { 'kind' },
                { 'source_name' },
              },
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx) return ctx.kind_icon .. ' ' end,
                },
                label = {
                  width = { fill = true, max = 40 },
                },
                source_name = {
                  text = function(ctx)
                    local map = {
                      lsp      = '[LSP]',
                      buffer   = '[Buf]',
                      snippets = '[Snip]',
                      path     = '[Path]',
                    }
                    return map[ctx.source_name] or ('[' .. ctx.source_name .. ']')
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
              border = 'single',
              max_width = 60,
              max_height = 20,
            },
          },
          ghost_text = { enabled = true },
        },
        signature = {
          enabled = true,
          window = { border = 'single' },
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      })
    end
  }
})

-- Exemplo de carregamento sob demanda (se quiser lazy load)
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd("packadd blink.cmp")
  end
})
