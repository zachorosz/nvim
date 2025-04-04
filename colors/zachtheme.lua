vim.api.nvim_command("hi clear")
if vim.fn.exists("syntax_on") then
	vim.api.nvim_command("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "zachtheme"

local palette = {
	bg = "#000000",
	fg = "#cacaca",
	comment = "#727272",
	primary = "#5fafd7",
	secondary = "#b0b0b0",
	red = "#ac4242",
}

local groups = {
	Normal = { fg = palette.fg, bg = palette.bg },
	NormalFloat = { fg = palette.fg, bg = "#141414" },
	Cursor = { fg = palette.bg, bg = palette.fg },
	lCursor = { fg = palette.bg, bg = palette.fg },
	CursorIM = { fg = palette.bg, bg = palette.fg },

	StatusLine = { fg = palette.fg, bg = palette.bg },
	StatusLineNC = { fg = palette.fg, bg = palette.bg },

	Comment = { fg = palette.comment },
	Variable = { fg = palette.fg },
	String = { fg = "#afd787" },
	Character = { fg = palette.fg },
	Constant = { fg = palette.fg },
	Number = { fg = palette.primary },
	Boolean = { fg = palette.primary },
	Float = { fg = palette.primary },
	Identifier = { fg = palette.fg },
	Function = { fg = palette.fg },
	Operator = { fg = palette.fg },
	Type = { fg = palette.fg },
	StorageClass = { fg = palette.fg },
	Structure = { fg = palette.fg },
	Typedef = { fg = palette.primary },
	Keyword = { fg = palette.fg },
	Statement = { fg = palette.fg },
	Conditional = { fg = palette.fg },
	Label = { fg = palette.fg },
	Exception = { fg = palette.fg },
	Include = { fg = palette.fg },
	PreProc = { fg = palette.fg },
	Define = { fg = palette.fg },
	Macro = { fg = palette.fg },
	Special = { fg = palette.fg },
	SpecialChar = { fg = palette.fg },
	SpecialComment = { fg = palette.fg },
	Tag = { fg = palette.fg },
	Delimiter = { fg = palette.fg },

	["@constant.builtin.go"] = { fg = palette.primary },
	["@type.builtin"] = { fg = palette.primary },
	["@variable"] = { fg = palette.fg },
	["@variable.builtin"] = { fg = palette.primary },
}

local function hl(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(groups) do
	hl(name, val)
end
