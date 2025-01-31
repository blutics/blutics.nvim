local M = {}

function M.search_by_aliases()

  -- obsidian client 가져오기
  --
  local client = require("obsidian").get_client()
  local vault_path = tostring(client.dir)

  -- ripgrep으로 aliases를 포함한 파일 찾기
  local cmd = string.format([[rg -U -l "aliases:\s*(\n\s*[-*]\s*[^\n]*)*" %s]], vault_path)
  local files = vim.fn.systemlist(cmd)

  -- 각 파일의 aliases 추출
  local all_aliases = {}
  local entries = {}
  for _, file in ipairs(files) do
    local content = vim.fn.readfile(file)
    local mtime = vim.fn.getftime(file) -- Unix timestamp 반환
    local mtime_str = vim.fn.strftime("%Y-%m-%d %H:%M:%S", mtime)
    local in_aliases = false
    local aliases = {}

    for _, line in ipairs(content) do
      if line:match("^aliases:") then
        in_aliases = true
      elseif in_aliases then
        local alias = line:match("^%s*[-*]%s*(.+)")
        if alias then
          table.insert(aliases, vim.trim(alias))
        else
          if line:match("^%s*[a-zA-Z]+:") then
            in_aliases = false
          end
        end
      end
    end

    if #aliases > 0 then
      local title = file:match("([^/]+)%.md$")
      for index, alias in pairs(aliases) do
        table.insert(entries, {
          index = index,
          length = #aliases,
          title = title,
          file = file,
          alias = alias,
          mtime = mtime_str,
        })
      end
    end
  end

  -- Telescope로 결과 표시
  require("telescope.pickers")
      .new({}, {
        prompt_title = "Obsidian Aliases",
        finder = require("telescope.finders").new_table({
          results = entries,
          entry_maker = function(entry)
            return {
              value = entry,
              display = string.format(
                "%15s | %19s | %2d | %2d | %s",
                entry.title,
                entry.mtime,
                entry.length,
                entry.index,
                entry.alias
              ),
              ordinal = entry.title .. " " .. entry.alias,
            }
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            -- 선택한 노트의 링크 삽입
            vim.api.nvim_put({ "[[" .. selection.value.title .. "|" .. selection.value.alias .. "]]" }, "", true, true)
          end)
          return true
        end,
      })
      :find()
end


return M
