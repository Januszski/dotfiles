-- plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
		},
		window = {
			border = "rounded",
		},
		layout = {
			align = "center",
		},
		show_help = true,
		ignore_missing = true,
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Top-level groups to make <leader> menu nice
		wk.register({
			["<leader>"] = {
				f = { name = "+file" },
				s = { name = "+search/replace" },
				t = { name = "+tabs" },
				x = { name = "+exec/misc" },
				d = { name = "+delete" },
				e = { name = "+explorer" },
				l = { name = "+lsp" },
				w = { name = "+workspace/session" },
				c = { name = "+code/cleanup" },
				m = { name = "+markdown/format" },
			},
		})
	end,
}
