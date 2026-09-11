vim.pack.add({
  "https://github.com/sphamba/smear-cursor.nvim",
})

local ok, smear = pcall(require, 'smear_cursor')
if ok then
  smear.setup({
    stiffness = 0.6,          -- Menor = mais rastro e lentidão agradável (padrão é 0.6)
    trailing_stiffness = 0.3, -- Rigidez da "cauda" que fica para trás

    distance_stop_animating = 0.1,
    hide_target_hack = false, -- Mude para true se o cursor piscar estranho ao parar

    cursor_color = "#E6C384",
  })
end
