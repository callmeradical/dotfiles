return {
  "olimorris/codecompanion.nvim",
  version = "v17.33.0", -- Pin to stable version to avoid breaking changes
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- Optional
  },
  cmd = { "CodeCompanionActions", "CodeCompanionToggle", "CodeCompanionAdd" }, -- Removed CodeCompanion command
  keys = {
    { "<leader>ai", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
    { "<leader>at", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion Chat" },
    { "<leader>ai", "<cmd>CodeCompanionAdd<cr>", mode = "v", desc = "Add Selected to CodeCompanion" },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        -- Disable inline strategy completely to avoid errors
        -- inline = {
        --   adapter = "anthropic",
        -- },
        agent = {
          adapter = "anthropic",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY",
            },
          })
        end,
      },
      opts = {
        log_level = "ERROR", -- Suppress debug/info logs
        system_prompt = function(opts)
          return "You are a helpful AI assistant integrated into Neovim. You can help with coding tasks, explanations, and general programming questions."
        end,
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
        chat = {
          window = {
            layout = "vertical", -- vertical|horizontal|float|buffer
            width = 0.45,
            height = 0.8,
          },
        },
      },
    })
  end,
}
