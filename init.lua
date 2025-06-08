-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.guicursor = "" -- block cursor
vim.opt.number = true
--vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- half page jumping; centering cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- keep cursor centered when going through search matches
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
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
                vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Telescope: Search [b]uffers" })
                vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Telescope: Search [h]elp" })
                vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "Telescope: Search [k]eymaps" })
                vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope: Search [f]iles" })
                vim.keymap.set("n", "<leader>pg", function()
                    builtin.grep_string({ search = vim.fn.input("Grep > ") })
                end, { desc = "Telescope: Search by [G]rep" })
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "bash",
                        "c",
                        "go",
                        "lua",
                        "rust",
                    },

                    -- Install parsers synchronously (only applied to `ensure_installed`)
                    sync_install = false,

                    -- Automatically install missing parsers when entering buffer
                    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                    auto_install = true,

                    -- List of parsers to ignore installing
                    ignore_install = {},

                    indent = {
                        enable = true,
                    },

                    highlight = {
                        enable = true,

                        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                        -- Using this option may slow down your editor, and you may see some duplicate highlights.
                        -- Instead of true it can also be a list of languages
                        additional_vim_regex_highlighting = false,
                    },
                })
            end,
        },
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references)
        vim.keymap.set("n", "grd", vim.lsp.buf.definition)

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/implementation') then
            -- Create a keymap for vim.lsp.buf.implementation ...
        end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

vim.lsp.enable({ 'gopls', 'lua_ls', 'rust-analyzer', 'ts_ls' })
vim.diagnostic.config({ virtual_text = true })

vim.cmd.colorscheme("zachtheme")
