return {
	"folke/trouble.nvim",
	config = function()
		local trouble = require("trouble")

		trouble.setup({
			icons = false,
			fold_open = "v",
			fold_closed = ">",
			indent_lines = false,
			signs = {
				error = "error",
				warning = "warn",
				hint = "hint",
				information = "info",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		})

		vim.keymap.set("n", "<leader>tt", function()
			trouble.toggle()
		end)

		vim.keymap.set("n", "]t", function()
			trouble.next({ skip_groups = true, jump = true })
		end)

		vim.keymap.set("n", "[t", function()
			trouble.previous({ skip_groups = true, jump = true })
		end)
	end,
}
