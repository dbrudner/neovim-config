local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local previewers = require("telescope.previewers")
local Previewer = previewers.new_buffer_previewer
--
-- Function to get the current branch name
local function get_current_branch()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD")

  if handle == nil then
    return ""
  end

  local branch = handle:read("*a"):gsub("\n", "")
  handle:close()
  return branch
end

-- Creating a custom previewer for the git diff
local git_diff_previewer = function()
  return Previewer({
    title = "Git Diff",
    define_preview = function(self, entry)
      if not entry.value then
        return
      end
      -- Extract commit hash from entry.value
      local commit_hash = entry.value:match("^(%S+)")
      if not commit_hash then
        return
      end

      -- Clearing the buffer
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {})

      -- Fetching git diff for the commit
      local current_branch = get_current_branch()
      local command = "git diff " .. current_branch .. " " .. commit_hash
      local handle = io.popen(command, "r")
      if handle then
        local results = {}
        for line in handle:lines() do
          table.insert(results, line)
        end
        handle:close()
        -- Set the lines to the buffer
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, results)
      end
    end,
  })
end

-- Function to get the list of commits from git log
local function get_git_commits()
  local command = "git log --pretty=format:'%h %s'"
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  local commits = {}
  for commit in result:gmatch("[^\r\n]+") do
    table.insert(commits, commit)
  end

  return commits
end

-- Telescope picker for git commits
function Git_commits()
  local commits = get_git_commits()

  pickers
    .new({}, {
      prompt_title = "Git Commits",
      finder = finders.new_table({
        results = commits,
      }),
      sorter = conf.generic_sorter({}),
      previewer = git_diff_previewer(),
      layout_strategy = "flex",
      layout_config = {
        horizontal = {
          preview_width = 0.4,
        },
        vertical = {
          preview_height = 0.4,
        },
        flex = {
          flip_columns = 120,
        },
      },
      attach_mappings = function(prompt_bufnr, map)
        local function on_select()
          local selected_commit = action_state.get_selected_entry().value
          actions.close(prompt_bufnr)
          -- Checkout the selected commit (if needed)
          -- os.execute("git checkout " .. selected_commit)
          -- Or perform any other action with the selected commit
        end

        map("i", "<CR>", on_select)
        map("n", "<CR>", on_select)
        return true
      end,
    })
    :find()
end

-- Command to invoke the custom picker
vim.api.nvim_set_keymap("n", "<leader>gc", "<cmd>lua Git_commits()<CR>", { noremap = true, silent = true })
