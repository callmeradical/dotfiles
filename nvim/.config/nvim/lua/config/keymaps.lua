-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode (jj)" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode (jk)" })
-- Add git diff accept keymaps for easier use
vim.keymap.set("n", "ac", function()
  -- Accept current hunk (git diff)
  if vim.fn.exists(":Gitsigns") > 0 then
    require("gitsigns").stage_hunk()
  else
    vim.notify("Gitsigns not available", vim.log.levels.WARN)
  end
end, { desc = "Accept/Stage current hunk" })

vim.keymap.set("n", "aa", function()
  -- Accept all hunks in file
  if vim.fn.exists(":Gitsigns") > 0 then
    require("gitsigns").stage_buffer()
  else
    vim.notify("Gitsigns not available", vim.log.levels.WARN)
  end
end, { desc = "Accept/Stage all hunks in buffer" })

-- Alternative: Use leader-prefixed versions if the above conflict
-- vim.keymap.set("n", "<leader>ga", function()
--   require("gitsigns").stage_hunk()
-- end, { desc = "Git Accept/Stage current hunk" })

-- vim.keymap.set("n", "<leader>gA", function()
--   require("gitsigns").stage_buffer()
-- end, { desc = "Git Accept/Stage all hunks in buffer" })
