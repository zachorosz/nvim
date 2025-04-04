return {
    cmd = { 'lua-language-server' },

    filetypes = { 'lua' },

    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },

    on_init = function(client)
        local path = vim.tbl_get(client, "workspace_folders", 1, "name")
        if not path then
            return
        end
        -- override the lua-language-server settings for Neovim config
        client.settings = vim.tbl_deep_extend('force', client.settings, {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            }
        })
    end,
}
