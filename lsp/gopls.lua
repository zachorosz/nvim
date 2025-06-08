return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            ["local"] = "github.com/zachorosz",
            analyses = {
                unusedparams = true,
            },
            usePlaceholders = true,
            staticcheck = true,
        }
    }
}
