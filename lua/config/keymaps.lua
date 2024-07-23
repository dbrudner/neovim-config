-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Lua function to jump to global marks
-- doing this because backtick is a pain to hit on my keyboard
vim.api.nvim_set_keymap("n", ";", "`", { noremap = true, silent = true })

function Jump_to_global_mark(mark)
  return function()
    vim.cmd("normal! `" .. mark)
  end
end

-- Jump to marks with 1 through 6
vim.api.nvim_set_keymap("n", "1", ":lua Jump_to_global_mark('Q')()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "2", ":lua Jump_to_global_mark('W')()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "3", ":lua Jump_to_global_mark('E')()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "4", ":lua Jump_to_global_mark('R')()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "5", ":lua Jump_to_global_mark('T')()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "6", ":lua Jump_to_global_mark('Y')()<CR>", { noremap = true, silent = true })
