return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      lsp_cfg = true, -- false: use your own setup
      lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
      max_active_buf = 6, -- go.nvim will deactive lsp on inactive buffers which are exceed max_active_buf number
      inlay_hints = {
        enabled = false, -- disable inlay hints
      },
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
