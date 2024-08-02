-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Lua function to jump to global marks
-- doing this because backtick is a pain to hit on my keyboard
vim.api.nvim_set_keymap("n", ";", "`zz", { noremap = true, silent = true })
