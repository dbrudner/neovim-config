return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  transarent = true,
  config = function()
    require("cyberdream").setup({
      transparent = true,
    })
  end,
  {
    "tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
