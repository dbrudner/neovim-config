return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    injections = {
      enable = true,
      languages = {
        go = {
          "sql",
        },
      },
    },

    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
      "sql",
      "go",
    },
  },
}
