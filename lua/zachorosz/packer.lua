-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use('p00f/alabaster.nvim')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('folke/trouble.nvim')
    use('tpope/vim-fugitive')

    use('neovim/nvim-lspconfig')
    use('ray-x/go.nvim')
    --    use {
    --        'VonHeikemen/lsp-zero.nvim',
    --        branch = 'v1.x',
    --        requires = {
    --            -- LSP Support
    --            { 'neovim/nvim-lspconfig' },
    --            { 'williamboman/mason.nvim' },
    --            { 'williamboman/mason-lspconfig.nvim' },
    --            { 'jose-elias-alvarez/null-ls.nvim' },
    --
    --            -- Autocompletion
    --            { 'hrsh7th/nvim-cmp' },
    --            { 'hrsh7th/cmp-buffer' },
    --            { 'hrsh7th/cmp-path' },
    --            { 'saadparwaiz1/cmp_luasnip' },
    --            { 'hrsh7th/cmp-nvim-lsp' },
    --            { 'hrsh7th/cmp-nvim-lua' },
    --
    --            -- Snippets
    --            { 'L3MON4D3/LuaSnip' },
    --            { 'rafamadriz/friendly-snippets' },
    --        }
    --    }
end)
