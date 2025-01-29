require("config.options") -- 기본 옵션 및 설정

require("config.lazy") -- 플러그인 등록

-- 플러그인 등록 후
-- Vim에 대한 설정 혹은 플러그인에 대한 추가 설정

require("config.autocmds")
require("config.keymaps") -- 키맵 등록

-- Windows PowerShell 경로 설정
local powershell_options = {
	shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
	shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
	shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
	shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
	shellquote = "",
	shellxquote = "",
}

-- for option, value in pairs(powershell_options) do
--   vim.opt[option] = value
-- end

require("config.after.options")
