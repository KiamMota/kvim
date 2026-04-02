-- lua/plugins/colorscheme.lua

vim.pack.add({
  'https://github.com/mofiqul/vscode.nvim',           -- VS Code dark
  "https://github.com/mofiqul/dracula.nvim",
})

-- Troque o nome para experimentar cada um:
-- 'vscode'       → VS Code dark
-- 'darcula'      → JetBrains Darcula
-- 'kanagawa'     → Kanagawa
-- 'tokyonight'   → Tokyo Night
-- 'catppuccin'   → Catppuccin Mocha

vim.cmd.colorscheme('vscode')
