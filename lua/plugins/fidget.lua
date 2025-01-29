return {
	"j-hui/fidget.nvim",
	opts = {
		-- options
		-- Options related to notification subsystem
		-- LSP 진행 상태 표시 설정
		progress = {
			poll_rate = 0.1, -- 진행 상태 업데이트 주기 (초)
			suppress_on_insert = false, -- insert 모드에서도 표시
			ignore_done_already = false, -- 이미 완료된 작업도 표시
			notification_group = function(msg) return msg.lsp_client.name end, -- 알림을 그룹화
			clear_on_detach = true, -- LSP 서버 분리시 진행 상태 삭제
		},

		-- 알림 설정
		notification = {
			poll_rate = 10, -- 알림 업데이트 주기 (밀리초)
			override_vim_notify = true, -- vim.notify 오버라이드
			window = {
				winblend = 0, -- 투명도 (0-100)
				border = "none", -- 테두리 스타일
				max_width = 80, -- 최대 너비
				max_height = 40, -- 최대 높이
			},
			view = {
				stack_upwards = true, -- 새 알림을 위에 추가
				icon_separator = " ", -- 아이콘 구분자
			},
		},
	},
}
