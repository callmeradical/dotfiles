return {
  "esensar/nvim-dev-container",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("devcontainer").setup({})
  end,
  cmd = {
    "DevcontainerStart",
    "DevcontainerAttach",
    "DevcontainerExec",
    "DevcontainerStop",
  },
}
