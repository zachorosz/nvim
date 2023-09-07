return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>pf", require("telescope.builtin").find_files, mode = "n", desc = "Search Files" },
			{ "<leader>gf", require("telescope.builtin").git_files, mode = "n", desc = "Search [G]it [F]iles" },
			{
				"<leader>pg",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				mode = "n",
				desc = "Search by [G]rep",
			},
		},
	},
}
