-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Set global marks with Ctrl + 1 through Ctrl + 6
vim.api.nvim_set_keymap("n", "<C-1>", "mA", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-2>", "mB", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-3>", "mC", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-4>", "mD", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-5>", "mE", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-6>", "mF", { noremap = true, silent = true })

-- Jump to marks with 1 through 6
vim.api.nvim_set_keymap("n", "1", "'A", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "2", "'B", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "3", "'C", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "4", "'D", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "5", "'E", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "6", "'F", { noremap = true, silent = true })
