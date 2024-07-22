return {
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        logging = false,
        filetype = {
          sql = {
            -- Use sqlfluff for formatting SQL files
            function()
              return {
                exe = "sqlfluff",
                args = { "fix", "--dialect", "postgres", "-" },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  },
}
