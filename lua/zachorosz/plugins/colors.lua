local function color_overrides()
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "Type", { link = "Normal" })
	vim.api.nvim_set_hl(0, "Keyword", { link = "Normal" })
end

local function disable_italics()
	local hl_groups = vim.api.nvim_get_hl(0, {})

	for key, hl_group in pairs(hl_groups) do
		if hl_group.italic then
			vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, { italic = false }))
		end
	end
end

return {
	--{
	--	"p00f/alabaster.nvim",
	--	priority = 1000,
	--	config = function()
	--		vim.g.alabaster_dim_comments = true
	--		vim.g.alabaster_floatborder = true
	--		vim.cmd.colorscheme("alabaster")
	--		color_overrides()
	--	end,
	--},
	{
		"kvrohit/rasmus.nvim",
		priority = 1000,
		config = function()
			vim.g.rasmus_italic_comments = false
			vim.cmd.colorscheme("rasmus")
			color_overrides()
			disable_italics()
		end,
	},
}
