return {
	"tpope/vim-fugitive",
	{
		"p00f/alabaster.nvim",
		priority = 1000,
		config = function()
			vim.g.alabaster_dim_comments = true
			vim.cmd.colorscheme("alabaster")
		end,
	},
}
