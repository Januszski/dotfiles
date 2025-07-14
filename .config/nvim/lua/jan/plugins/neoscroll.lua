return {
	"karb94/neoscroll.nvim",
	event = "WinScrolled",
	config = function()
		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>" },
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			duration_multiplier = 1.0,
			easing = "linear",
			pre_hook = nil,
			post_hook = nil,
			performance_mode = false,
			ignored_events = { "WinScrolled", "CursorMoved" },
		})

		local t = {}
		-- Scroll 20 lines in 60ms (fast)
		t["<C-u>"] = { "scroll", { "-30", "true", "250" } }
		t["<C-d>"] = { "scroll", { "30", "true", "250" } }

		require("neoscroll.config").set_mappings(t)
	end,
}
