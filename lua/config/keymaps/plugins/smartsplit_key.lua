vim.keymap.set("n", "<C-A-h>", function()
	require("smart-splits").resize_left()
end)
vim.keymap.set("n", "<C-A-j>", function()
	require("smart-splits").resize_down()
end)
vim.keymap.set("n", "<C-A-k>", function()
	require("smart-splits").resize_up()
end)
vim.keymap.set("n", "<C-A-l>", function()
	require("smart-splits").resize_right()
end)
-- moving between splits
vim.keymap.set("n", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end)
vim.keymap.set("n", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end)
vim.keymap.set("n", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end)
vim.keymap.set("n", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end)
vim.keymap.set("n", "<C-\\>", function()
	require("smart-splits").move_cursor_previous()
end)
-- swapping buffers between windows
-- vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
-- vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
-- vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
-- vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
