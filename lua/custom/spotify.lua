function Open_spotify_popup()
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Define window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open the window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Start the Spotify player in the terminal buffer
  vim.fn.termopen("spotify_player")

  -- Optional: Set key mapping to close the popup
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<Cmd>bd!<CR>", { noremap = true, silent = true })
end

vim.api.nvim_create_user_command("SpotifyPopup", Open_spotify_popup, {})

vim.api.nvim_set_keymap(
  "n",
  "<leader>sp",
  ":SpotifyPopup<CR>",
  { noremap = true, silent = true, desc = "Open Spotify Popup" }
)
