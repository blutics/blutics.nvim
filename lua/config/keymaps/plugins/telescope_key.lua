-- print("hello Telescope Keymap!!")

local builtin = require("telescope.builtin")
--
--
vim.keymap.set("n", "<leader>f", "", { desc = "Telescope!" })
-- 파일 찾기
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
-- 문자열 검색
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
-- 버퍼 목록
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
-- 도움말 태그 검색
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>fn", "<Cmd>Telescope noice<CR>", { desc = "Telescope noice messages" })

vim.keymap.set("n", "<leader>fc", "<Cmd>Telescope command_history<Cr>", { desc = "Telescope command history" })
vim.keymap.set("n", "<leader>fz", "<Cmd>Telescope commands<Cr>", { desc = "Telescope commands" })

-- 최근 열었던 파일
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recently opened files" })

-- 키맵 검색
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search keymaps" })

vim.keymap.set("n", "<leader>ft", "<Cmd>Telescope telescope-tabs list_tabs<Cr>", { desc = "Tabs" })

vim.keymap.set("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics({ bufnr = 0 })
end, { desc = "Diagnostics" })


-- 컴프리스트
vim.keymap.set("n", "<leader>fj", function()
  require("telescope.builtin").jumplist({
    show_line = true,
    fname_width = 50,
    include_current_position = true,
  })
end)
