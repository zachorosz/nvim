return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Telescope: Search [H]elp" })
			vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "Telescope: Search [K]eymaps" })
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope: Search [F]iles" })
			vim.keymap.set("n", "<leader>pg", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Telescope: Search by [G]rep" })
		end,
	},
}
