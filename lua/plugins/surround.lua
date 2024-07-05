return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        insert = "<leader>n<C-g>s",
        insert_line = "<leader>n<C-g>S",
        normal = "<leader>nys",
        normal_cur = "<leader>nyss",
        normal_line = "<leader>nyS",
        normal_cur_line = "<leader>nySS",
        visual = "<leader>nS",
        visual_line = "<leader>ngS",
        delete = "<leader>nds",
        change = "<leader>ncs",
        change_line = "<leader>ncS",
      },
    })
  end,
}
