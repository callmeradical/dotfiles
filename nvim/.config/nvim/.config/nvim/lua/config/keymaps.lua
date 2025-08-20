-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode (jj)" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode (jk)" })
vim.keymap.set("n", "<leader>af", function()
  require("conform").format({ async = true })
end, { desc = "Format file (conform)" })
