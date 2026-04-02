-- lua/plugins/neo-tree.lua

-- Dependências antes do plugin principal
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/MunifTanjim/nui.nvim',
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
})

require('neo-tree').setup({
  close_if_last_window = true,

  window = {
    position = 'float',
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
  },

  filesystem = {
    filtered_items = {
      hide_dotfiles   = false,
      hide_gitignored = false,
    },
    follow_current_file = {
      enabled        = true,
      leave_dirs_open = false,
    },
  },

  event_handlers = {
    {
      event = 'neo_tree_buffer_enter',
      handler = function()
        vim.opt_local.number         = true
        vim.opt_local.relativenumber = false
        vim.opt_local.numberwidth    = 4
      end,
    },
    {
      event = 'file_opened',
      handler = function()
        require('neo-tree.command').execute({ action = 'close' })
      end,
    },
  },
})

vim.schedule(function()
  vim.keymap.set('n', '<leader>e', function()
    local manager  = require('neo-tree.sources.manager')
    local renderer = require('neo-tree.ui.renderer')
    local state    = manager.get_state('filesystem')

    if renderer.window_exists(state) then
      require('neo-tree.command').execute({ action = 'close' })
    else
      require('neo-tree.command').execute({
        action   = 'focus',
        source   = 'filesystem',
        position = 'float',
        reveal   = true,
        dir      = vim.fn.getcwd(),
      })
    end
  end, { desc = 'Toggle Neo-tree (Float + Reveal)' })
end)