vim.keymap.set("n", "<leader>b", "", { desc = "Obsidian" })

vim.keymap.set("n", "<leader>bn", function()
	-- 워크스페이스 목록 가져오기
	local obsidian = require("obsidian")
	local client = obsidian.get_client()
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

local toc_telescope = require("custom.obsidian_custom_toc_with_telescope")
vim.keymap.set("n", "<leader>bc", toc_telescope.markdown_toc_in_telescope, { desc = "TOC with Telescope" })

-- 체크박스 제거 함수
local function remove_checkbox()
	local line = vim.api.nvim_get_current_line()
	-- "- [ ]" 또는 "- [x]"를 "-"로 변경
	local new_line = line:gsub("^(%s*)%-%s%[.?%]%s(.*)", "%1%2 ")
	vim.api.nvim_set_current_line(new_line)
end

-- 키매핑
vim.keymap.set("n", "<leader>bh", remove_checkbox, { desc = "Release Checkbox" })

vim.keymap.set("n", "<leader>bd", "<Cmd>ObsidianDailies<Cr>", { desc = "Dailies" })
