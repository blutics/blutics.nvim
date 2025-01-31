local custom_obsidian = require("custom.obsidian_custom")
local toc_telescope = require("custom.obsidian_custom_toc_with_telescope")

vim.keymap.set("n", "<leader>b", "", { desc = "Obsidian" })
vim.keymap.set("n", "<leader>ba", custom_obsidian.search_by_aliases, { desc = "Find by aliases" })
vim.keymap.set("n", "<leader>bw", "<Cmd>ObsidianWorkspace<Cr>", { desc = "Change Obsidian Workspace" })
vim.keymap.set("n", "<leader>bb", "<Cmd>ObsidianBacklinks<Cr>", { desc = "Telescope BackLinks" })
vim.keymap.set("n", "<leader>bt", "<Cmd>ObsidianTags<Cr>", { desc = "Telescope Tags in this Vault" })
vim.keymap.set("n", "<leader>br", "<Cmd>ObsidianRename<Cr>", { desc = "Rename!" })
vim.keymap.set("n", "<leader>bc", toc_telescope.markdown_toc_in_telescope, { desc = "TOC with Telescope" })
vim.keymap.set("n", "<leader>bh", custom_obsidian.remove_checkbox, { desc = "Release Checkbox" }) -- 체크박스 제거 함수
vim.keymap.set("n", "<leader>bd", "<Cmd>ObsidianDailies<Cr>", { desc = "Dailies" })
vim.keymap.set("n", "<leader>bn", function()
	custom_obsidian.get_obsidian_directories(function(relative_path)
		vim.ui.input({
			prompt = "🎵 Enter note name: ",
		}, function(input)
			if input then
				vim.cmd("ObsidianNew " .. relative_path .. "/" .. input .. ".md")
			end
		end)
	end)
end)

vim.keymap.set("n", "<leader>bA", function()
	custom_obsidian.get_obsidian_directories(function(relative_path)
		print(relative_path)
		local obsidian = require("obsidian")
		local client = obsidian.get_client()

		local vault_path = client.current_workspace.path.filename
		local abs_path = vault_path .. "/" .. relative_path
		print(abs_path)
		custom_obsidian.search_by_aliases_in_vautl_dir_path(abs_path)
	end)
end, { desc = "description" })
