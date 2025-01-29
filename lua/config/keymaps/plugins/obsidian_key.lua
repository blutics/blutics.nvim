local obsidian = require("obsidian")
local client = obsidian.get_client()
vim.keymap.set("n", "<leader>b", "", { desc = "Obsidian" })

vim.keymap.set("n", "<leader>bn", function()
  -- 워크스페이스 목록 가져오기
  local vault_path = client.current_workspace.path.filename

  require("telescope").extensions.file_browser.file_browser({
    prompt_title = "Create Note in Current Vault",
    cwd = vault_path,
    hidden = false,
    respect_gitignore = false,
    previewer = false,
    select_buffer = true,
    only_dirs = true,
    files = false, -- 파일 표시 비활성화
    depth = 1, -- 한 번에 한 레벨만 표시
    dir_icon = "📁", -- 디렉토리 아이콘
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local create_note = function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        local relative_path = string.sub(selection.path, #vault_path + 2)

        vim.ui.input({
          prompt = "🎵 Enter note name: ",
        }, function(input)
          if input then
            vim.cmd("ObsidianNew " .. relative_path .. "/" .. input .. ".md")
          end
        end)
      end
      map("i", "<CR>", create_note)
      map("n", "<CR>", create_note)
      return true
    end,
    layout_strategy = "vertical", -- 'horizontal', 'center' 등
    layout_config = {
      width = 0.4,
      height = 0.6,
    },
    sorting_strategy = "descending",
    prompt_title = "🌟 Recently 🌟", -- 커스텀 제목 설정
  })
end)

vim.keymap.set("n", "<leader>bw", "<Cmd>ObsidianWorkspace<Cr>", { desc = "Change Obsidian Workspace" })
vim.keymap.set("n", "<leader>bb", "<Cmd>ObsidianBacklinks<Cr>", { desc = "Telescope BackLinks" })

vim.keymap.set("n", "<leader>bt", "<Cmd>ObsidianTags<Cr>", { desc = "Telescope Tags in this Vault" })
vim.keymap.set("n", "<leader>br", "<Cmd>ObsidianRename<Cr>", { desc = "Rename!" })




