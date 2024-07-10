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
  local output = get_command_output("git reflog --pretty='%gs' | awk '{print $NF}' | grep -v '^$' | sort | uniq")
  local branches = {}
  for branch in output:gmatch("[^\r\n]+") do
    table.insert(branches, branch)
  end
  return branches
end

-- Telescope picker for git branches
function _G.git_branch_picker()
  local branches = get_git_branches()

  pickers
    .new({}, {
      prompt_title = "Git Branches",
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
vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd>lua git_branch_picker()<CR>", { noremap = true, silent = true })
