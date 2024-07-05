-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "dd", function()
  local fileExtension = vim.fn.expand("%:e")
  if fileExtension == "tsx" or fileExtension == "jsx" then
    local currentLine = vim.api.nvim_get_current_line()
    local firstNonWhiteSpaceCharacter = string.sub(string.gsub(currentLine, "%s+", ""), 1, 1)

    if firstNonWhiteSpaceCharacter == "<" then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Plug>(nvim-surround-delete)t", true, true, true),
        "n",
        true
      )
    else
      vim.cmd("normal! dd")
    end
  else
    vim.cmd("normal! dd")
  end
end)
