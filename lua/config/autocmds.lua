-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.cmd([[
--   augroup TemplFmt
--     autocmd!
--     autocmd BufWritePost *.templ silent! execute "!PATH=\"$PATH:$(go env GOPATH)/bin\" templ fmt <afile> >/dev/null 2>&1" | redraw!
--   augroup END
-- ]])

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
