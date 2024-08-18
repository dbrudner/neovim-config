return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          config = {
            filetypes = { "templ", "astro", "javascript", "typescript", "react" },
          },
        },
      },
      setup = {},
    },
  },
}
