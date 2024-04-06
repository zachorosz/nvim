return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end

			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			nmap("<leader>f", function()
				lsp_formatting(bufnr)
			end, "[F]ormat")
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			nmap("K", vim.lsp.buf.hover, "Hover documentation")
			nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			bufls = {},
			gopls = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					usePlaceholders = true,
				},
			},
			lua_ls = {
				Lua = {
					diagnostics = {
						globals = {
							"vim",
							-- AwesomeWM
							"awesome",
							"client",
							"root",
						},
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
							"/usr/share/awesome/lib",
						},
					},
					telemetry = {
						enabled = false,
					},
				},
			},
		}

		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end,
		})
	end,
}
