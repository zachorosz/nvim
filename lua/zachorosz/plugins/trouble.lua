return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
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
			require("trouble").toggle()
		end)

		vim.keymap.set("n", "]t", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end)

		vim.keymap.set("n", "[t", function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end)
	end,
}
