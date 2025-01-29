require("config.keymaps.plugins.telescope_key")
require("config.keymaps.plugins.git_key")
require("config.keymaps.plugins.overseer_key")
require("config.keymaps.plugins.smartsplit_key")
require("config.keymaps.plugins.lsp_key")
require("config.keymaps.plugins.window_key")
require("config.keymaps.plugins.tab_key")
require("config.keymaps.plugins.neotest_key")
require("config.keymaps.plugins.obsidian_key")
-- Fterm

-- FTerm을 열고 닫는 단축키 매핑
-- vim.keymap.set("n", "<F2>", '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
-- vim.keymap.set("t", "<F2>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })

-- ToggleTerm
-- 기본 키 매핑
--
vim.keymap.set("n", "<C-\\>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>o", "<Cmd>Portal jumplist backward<Cr>", { desc = "Portal backward" })
vim.keymap.set("n", "<leader>i", "<Cmd>Portal jumplist forward<Cr>", { desc = "Portal forward" })

vim.keymap.set("n", "<leader><leader>n", "<Cmd>NoiceAll<Cr>", { desc = "Noice All" })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


vim.keymap.set("n", "<leader><leader>d", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss noice message" })

vim.keymap.set("n", "<leader><leader>h", "<Cmd>Fidget history<Cr>", { desc = "Fidget History" })

-- 가장 최근의 알림창만 닫기
-- vim.keymap.set("n", "<leader>nl", "<cmd>NoiceDissmiss<CR>", { desc = "Dismiss last message" })

vim.keymap.set("n", "<leader><leader>cd", function()
  local global_cwd = vim.fn.getcwd(-1) -- 전역 (-1)
  local tab_cwd = vim.fn.getcwd(-1, 0) -- 현재 탭
  local win_cwd = vim.fn.getcwd()      -- 현재 창

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
