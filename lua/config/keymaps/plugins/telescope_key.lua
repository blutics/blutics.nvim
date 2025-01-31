vim.keymap.set("n", "<leader>f", "", { desc = "Telescope!" })
-- 파일 찾기
vim.keymap.set("n", "<leader>ff", "<Cmd>Telescope find_files<Cr>", { desc = "Telescope find files" })
-- 문자열 검색
vim.keymap.set("n", "<leader>fg", "<Cmd>Telescope live_grep<Cr>", { desc = "Telescope live grep" })
-- 버퍼 목록
vim.keymap.set("n", "<leader>fb", function()
  require("telescope.builtin").buffers({
    layout_strategy = "vertical", -- 'horizontal', 'center' 등
    layout_config = {
      width = 0.4,
      height = 0.6,
    },
    sorting_strategy = "descending",
    prompt_title = "🌟 Buffers 🌟", -- 커스텀 제목 설정
  })
end, { desc = "Telescope buffers" })
-- 도움말 태그 검색
vim.keymap.set("n", "<leader>fh", "<Cmd>Telescope help_tags<Cr>", { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>fn", "<Cmd>Telescope noice<CR>", { desc = "Telescope noice messages" })

vim.keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").command_history({
    layout_strategy = "vertical", -- 'horizontal', 'center' 등
    layout_config = {
      width = 0.4,
      height = 0.8,
    },
    sorting_strategy = "descending",
    prompt_title = "🌟 Command History 🌟", -- 커스텀 제목 설정
  })
end, { desc = "Telescope command history" })
vim.keymap.set("n", "<leader>fz", "<Cmd>Telescope commands<Cr>", { desc = "Telescope commands" })

-- 최근 열었던 파일
vim.keymap.set("n", "<leader>fr", function()
  require("telescope.builtin").oldfiles({
    layout_strategy = "vertical", -- 'horizontal', 'center' 등
    layout_config = {
      width = 0.4,
      height = 0.6,
    },
    sorting_strategy = "descending",
    prompt_title = "🌟 Recently 🌟", -- 커스텀 제목 설정
  })
end, { desc = "Recently opened files" })

-- 키맵 검색
vim.keymap.set("n", "<leader>fk", "<Cmd>Telescope keymaps<Cr>", { desc = "Search keymaps" })

vim.keymap.set("n", "<leader>ft", "<Cmd>Telescope telescope-tabs list_tabs<Cr>", { desc = "Tabs" })

vim.keymap.set("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics({ bufnr = 0 })
end, { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>fp", function()
  require("telescope").extensions.projects.projects({
    layout_strategy = "vertical", -- 'horizontal', 'center' 등
    layout_config = {
      width = 0.4,
      height = 0.6,
    },
    sorting_strategy = "descending",
    prompt_title = "🌟 My Projects 🌟", -- 커스텀 제목 설정
    previewer = false, -- 미리보기 비활성화
    -- winblend = 15, -- 창 투명도 조정
  })
end, { noremap = true, silent = true, desc = "Find projects" })

-- 컴프리스트
vim.keymap.set("n", "<leader>fj", function()
  require("telescope.builtin").jumplist({
    show_line = true,
    fname_width = 50,
    include_current_position = true,
  })
end)

vim.keymap.set("n", "<leader>fd", "<Cmd>TodoTelescope<Cr>", { desc = "Telescope TODOs" })

