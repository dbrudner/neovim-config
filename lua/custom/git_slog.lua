local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- Function to run shell commands and capture the output
local function get_command_output(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Function to get the list of branches from git reflog
local function get_git_branches()
  local command =
    [[git reflog --date=iso --pretty='%gd: %gs' | grep 'checkout: moving from ' | sed -E 's/.*checkout: moving from (.*) to (.*)/\2/' | grep -vE 'HEAD~?[0-9]*|^refs/heads/|^[0-9a-f]{7,40}$' | nl | sort -uk2,2 | sort -nr | cut -f2-]]
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  local branches = {}
  for branch in result:gmatch("[^\r\n]+") do
    table.insert(branches, branch)
  end

  local reversed_branches = {}
  for i = #branches, 1, -1 do
    table.insert(reversed_branches, branches[i])
  end

  return reversed_branches
end

-- Telescope picker for git branches
function _G.git_slog()
  local branches = get_git_branches()

  pickers
    .new({}, {
      prompt_title = "Git Slog",
      finder = finders.new_table({
        results = branches,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        local function on_select()
          local selected_branch = action_state.get_selected_entry().value
          actions.close(prompt_bufnr)
          -- Commit changes with a generic message if there are any
          os.execute("git add .")
          os.execute("git commit -m 'Auto commit before branch switch'")
          -- Switch to the selected branch
          os.execute("git checkout " .. selected_branch)
        end

        map("i", "<CR>", on_select)
        map("n", "<CR>", on_select)
        return true
      end,
    })
    :find()
end

-- Command to invoke the custom picker
vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd>lua git_slog()<CR>", { noremap = true, silent = true })
