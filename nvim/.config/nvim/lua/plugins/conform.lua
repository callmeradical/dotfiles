return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      yaml = { "yamlfmt" },
      markdown = { "prettier" },
    },
    formatters = {
      yamlfmt = {
        command = "yamlfmt",
        args = { "-formatter", "basic", "-indentless_arrays=true" },
      },
      prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "$FILENAME", "--prose-wrap", "always" },
        stdin = true,
      },
    },
  },
}
