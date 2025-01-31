require("config.keymaps.plugins.telescope_key")
require("config.keymaps.plugins.git_key")
require("config.keymaps.plugins.overseer_key")
require("config.keymaps.plugins.smartsplit_key")
require("config.keymaps.plugins.lsp_key")
require("config.keymaps.plugins.window_key")
require("config.keymaps.plugins.tab_key")
require("config.keymaps.plugins.neotest_key")
require("config.keymaps.plugins.obsidian_key")

-- ToggleTerm
-- 기본 키 매핑

vim.keymap.set("n", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>o", "<Cmd>Portal jumplist backward<Cr>", { desc = "Portal backward" })
vim.keymap.set("n", "<leader>i", "<Cmd>Portal jumplist forward<Cr>", { desc = "Portal forward" })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local todo_custom = require("custom.todo_custom_comment")

vim.keymap.set("n", "<leader>/t", function()
  todo_custom.add_todo_comment("todo")
end, { desc = "Add todo" })

vim.keymap.set("n", "<leader><leader>h", function()
  require("telescope").extensions.notify.notify({
    layout_strategy = "vertical",
    layout_config = {
      width = 0.6,
      preview_height = 0.6,
    },
  })
end, { desc = "Fidget History" })
vim.keymap.set("n", "<leader><leader>d", ":Alpha<CR>", { noremap = true, silent = true, desc = "Alpha Dashboard" })
-- 가장 최근의 알림창만 닫기
-- vim.keymap.set("n", "<leader>nl", "<cmd>NoiceDissmiss<CR>", { desc = "Dismiss last message" })

vim.keymap.set("n", "<leader><leader>cd", function()
  local global_cwd = vim.fn.getcwd(-1) -- 전역 (-1)
  local tab_cwd = vim.fn.getcwd(-1, 0) -- 현재 탭
  local win_cwd = vim.fn.getcwd()     -- 현재 창

  -- 각 경로를 프로젝트 이름만 표시하도록 변환
  local function get_project_name(path)
    return vim.fn.fnamemodify(path, ":t")
  end

  local msg = string.format(
    "Global(cd): %s\nTab(tcd): %s\nWindow(lcd): %s",
    get_project_name(global_cwd),
    get_project_name(tab_cwd),
    get_project_name(win_cwd)
  )

  vim.notify(msg, vim.log.levels.INFO, {
    title = "Current Working Directories",
    timeout = 3000, -- 3초간 표시
  })
end, { desc = "Show current working directories" })

vim.keymap.set("n", "<leader><leader>/", "<Cmd>noh<Cr>", { desc = "Unlight highlight!" })

local aaat = require("custom.obsidian_custom_add_aliases_and_tags")

-- 키매핑 설정
vim.keymap.set("n", "<leader>bya", aaat.modify_aliases, { desc = "Modify aliases in frontmatter" })
vim.keymap.set("n", "<leader>byt", aaat.modify_tags, { desc = "Append Yaml Tags" })

-- aliases를 검색하는 함수

