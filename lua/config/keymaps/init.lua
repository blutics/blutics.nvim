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

vim.keymap.set("n", "<leader><leader>n", "<Cmd>NoiceAll<Cr>", { desc = "Noice All" })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local todo_custom = require("custom.todo_custom_comment")

vim.keymap.set("n", "<leader>/t", function()
  todo_custom.add_todo_comment("todo")
end, { desc = "Add todo" })

vim.keymap.set("n", "<leader><leader>d", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss noice message" })

vim.keymap.set("n", "<leader><leader>h", "<Cmd>Fidget history<Cr>", { desc = "Fidget History" })

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

local obsidian_custom = require("custom.obsidian_custom_add_aliases_and_tags")

-- 키매핑 설정
vim.keymap.set("n", "<leader>bya", obsidian_custom.modify_aliases, { desc = "Modify aliases in frontmatter" })
vim.keymap.set("n", "<leader>byt", obsidian_custom.modify_tags, { desc = "Append Yaml Tags" })

-- aliases를 검색하는 함수
local function search_by_aliases()
  -- obsidian client 가져오기
  --
  local telescope = require("telescope")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local client = require("obsidian").get_client()
  if not client then
    vim.notify("Obsidian client not found", vim.log.levels.ERROR)
    return
  end

  -- 모든 노트 가져오기
  local notes = client:find_notes("")

  local entries = {}

  -- local function search_by_aliases()
  local client = require("obsidian").get_client()
  if not client then
    vim.notify("Obsidian client not found", vim.log.levels.ERROR)
    return
  end

  -- 비동기로 노트 검색
  client:find_notes_async("", function(notes)
    -- vim.schedule로 UI 업데이트 처리
    vim.schedule(function()
      local entries = {}

      for _, note in ipairs(notes) do
        print(note)
        for k, v in pairs(note) do
          print(k, v)
        end
        if note.aliases then
          for _, alias in ipairs(note.aliases) do
            table.insert(entries, {
              value = note.path,
              display = alias .. " (" .. note.path .. ")",
              ordinal = alias,
              path = note.path,
            })
          end
        end
      end

      -- Telescope picker 생성
      pickers
          .new({}, {
            prompt_title = "Search Aliases",
            finder = finders.new_table({
              results = entries,
              entry_maker = function(entry)
                return {
                  value = entry.value,
                  display = entry.display,
                  ordinal = entry.ordinal,
                  path = entry.path,
                  lnum = 1,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            previewer = conf.file_previewer({}),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd("edit " .. selection.value)
              end)
              return true
            end,
          })
          :find()
    end)
  end)
end
-- 키매핑 설정
vim.keymap.set("n", "<leader>fa", search_by_aliases, { desc = "Find by aliases" })
