vim.pack.add({"https://github.com/nvim-tree/nvim-tree.lua"});

require("nvim-tree").setup({
  update_cwd = true,
  view = {
    float = {
      enable = true,
      open_win_config = {
        border = "rounded",
        width = 40,
      },
    },
  },
})

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { noremap = true, silent = true })

local function set_tree_cwd()
  local api = require("nvim-tree.api")
  local node = api.tree.get_node_under_cursor()
  
  if node and node.absolute_path then
    if vim.fn.isdirectory(node.absolute_path) == 1 then
      vim.cmd("cd " .. node.absolute_path)
      print("cwd changed to: " .. node.absolute_path)
    else
      print("Selecione uma pasta, não um arquivo")
    end
  end
end

-- Map para nvim-tree (quando a árvore está aberta)
vim.keymap.set("n", "<leader>cd", set_tree_cwd, { noremap = true, silent = true })
