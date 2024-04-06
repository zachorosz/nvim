local function colorscheme(color)
	color = color or "alabaster"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"p00f/alabaster.nvim",
		priority = 1000,
		config = function()
			vim.g.alabaster_dim_comments = true
			colorscheme("alabaster")
		end,
	},
}
