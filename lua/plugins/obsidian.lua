return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  note_frontmatter_fmt = function(note)
    -- 현재 시간 포맷팅
    local current_time = os.date("%Y-%m-%d %H:%M")

    -- 새 노트 생성시
    if not note.metadata or not note.metadata.created then
      return {
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
        created = current_time, -- 생성 시간 설정
        updated = current_time, -- 처음에는 생성 시간과 동일
      }
    end

    -- 기존 노트 업데이트시
    return {
      id = note.id,
      aliases = note.aliases,
      tags = note.tags,
      created = note.metadata.created, -- 기존 생성 시간 유지
      updated = current_time,       -- 현재 시간으로 업데이트
    }
  end,
  opts = {
    templates = {
      folder = "templates",
      -- date_format = "%Y-%m-%d",
      -- time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {
        -- aliases = "\n  - "
      },
    },
    workspaces = {
      {
        name = "personal",
        path = "/mnt/d/obsidian/personal_vault/",
        templates = {
          subdir = "templates",
          default_template = "default", -- 기본 템플릿 파일 이름 (확장자 제외)
        },
      },
      {
        name = "tech",
        path = "/mnt/d/obsidian/tech_vault/",
      },
    },
    completion = {
      nvim_cmp = true,
    },

    -- see below for full list of options 👇
  },
}
