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

local function wrap_try_catch()
  -- Get the range of the selected lines
  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]

  -- Get the selected lines
  local lines = vim.fn.getline(start_line, end_line)

  -- Ensure lines is always an array
  if type(lines) == "string" then
    lines = { lines }
  end

  -- Add indentation to the selected lines
  for i, line in ipairs(lines) do
    lines[i] = "    " .. line
  end

  -- Insert try/catch block
  table.insert(lines, 1, "try {")
  table.insert(lines, "}")
  table.insert(lines, "catch (e) {")
  table.insert(lines, "    ")
  table.insert(lines, "}")

  -- Set the modified lines back to the buffer
  vim.fn.setline(start_line, lines)

  -- Move the cursor to the line inside the catch block
  vim.api.nvim_win_set_cursor(0, { start_line + #lines - 2, 4 })
end

-- Key mapping to wrap highlighted code in try/catch
vim.keymap.set("v", "<Leader>tc", function()
  wrap_try_catch()
end, { noremap = true, silent = true })
